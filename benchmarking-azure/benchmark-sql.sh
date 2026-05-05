#!/bin/bash
###############################################################################
# BENCHMARK: Azure SQL Server & Database
# Referensi: GOV-POL Area 5 (Enkripsi), Area 6 (IAM), Area 8 (Hardening, VAPT)
#            GOV-POL Area 10 (BCP/DRP)
#            PROC-03 Sec.2.2, Sec.2.4, Sec.2.6
#            PROC-08 Sec.2.3 (DR geo-redundancy)
# Subscription: AzureCSP_Pusaka
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-sql.txt"
JSON_DIR="$OUTPUT_DIR/raw-json"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

PASS=0; FAIL=0; WARN=0; INFO=0

mkdir -p "$JSON_DIR"

log()   { echo "$1" | tee -a "$REPORT"; }
pass()  { PASS=$((PASS+1)); log "[PASS]  $1"; }
fail()  { FAIL=$((FAIL+1)); log "[FAIL]  $1"; }
warn()  { WARN=$((WARN+1)); log "[WARN]  $1"; }
info()  { INFO=$((INFO+1)); log "[INFO]  $1"; }

cat /dev/null > "$REPORT"
log "============================================================"
log "  AZURE SQL SERVER & DATABASE SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "  Subscription: $SUBSCRIPTION"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

###############################################################################
# 1. Enumerate semua SQL Servers
###############################################################################
log "--- Enumerasi SQL Servers ---"
az sql server list --query "[].{name:name, rg:resourceGroup, location:location, fqdn:fullyQualifiedDomainName}" -o json > "$JSON_DIR/sql-servers.json"
SERVERS=$(az sql server list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$SERVERS" | grep -c "." || echo 0)
log "Total SQL Server ditemukan: $TOTAL"
log ""

###############################################################################
# 2. Per-server checks
###############################################################################
while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "=== SQL SERVER: [$NAME] (RG: $RG) ==="

  SRV=$(az sql server show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  #---------------------------------------------------------------------------
  # CHECK 1: Minimum TLS Version >= 1.2 (GOV-POL Area 5)
  #---------------------------------------------------------------------------
  MIN_TLS=$(echo "$SRV" | jq -r '.minimalTlsVersion // "null"')
  if [ "$MIN_TLS" = "1.2" ] || [ "$MIN_TLS" = "1.3" ]; then
    pass "$NAME - TLS Minimum: $MIN_TLS"
  else
    fail "$NAME - TLS Minimum: $MIN_TLS (harus >= 1.2) [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 2: Public Network Access (GOV-POL Area 8.3.3)
  #---------------------------------------------------------------------------
  PUBLIC_NET=$(echo "$SRV" | jq -r '.publicNetworkAccess // "null"')
  if [ "$PUBLIC_NET" = "Disabled" ]; then
    pass "$NAME - Public Network Access: Disabled"
  else
    warn "$NAME - Public Network Access: $PUBLIC_NET (disarankan Disabled, gunakan PE) [GOV-POL Area 8.3.3]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 3: Azure AD Only Authentication (GOV-POL Area 6 - IAM Hardening)
  #---------------------------------------------------------------------------
  AAD_ONLY=$(echo "$SRV" | jq -r '.administrators.azureAdOnlyAuthentication // "null"')
  if [ "$AAD_ONLY" = "true" ]; then
    pass "$NAME - Azure AD Only Auth: Enabled"
  else
    warn "$NAME - Azure AD Only Auth: Disabled (SQL auth masih aktif) [GOV-POL Area 6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 4: Azure AD Admin Configured
  #---------------------------------------------------------------------------
  AAD_ADMIN=$(echo "$SRV" | jq -r '.administrators.login // "null"')
  if [ "$AAD_ADMIN" != "null" ] && [ -n "$AAD_ADMIN" ]; then
    pass "$NAME - Azure AD Admin: $AAD_ADMIN"
  else
    fail "$NAME - Azure AD Admin: Tidak dikonfigurasi [GOV-POL Area 6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 5: Auditing Enabled (PROC-03 Sec.2.6 - Audit Trail Database)
  #---------------------------------------------------------------------------
  AUDIT=$(az sql server audit-policy show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  AUDIT_STATE=$(echo "$AUDIT" | jq -r '.state // "null"')
  if [ "$AUDIT_STATE" = "Enabled" ]; then
    AUDIT_RETENTION=$(echo "$AUDIT" | jq -r '.retentionDays // 0')
    if [ "$AUDIT_RETENTION" -ge 90 ] 2>/dev/null; then
      pass "$NAME - Auditing: Enabled (retensi: ${AUDIT_RETENTION} hari)"
    else
      warn "$NAME - Auditing: Enabled tapi retensi $AUDIT_RETENTION hari (min. 90 hari) [PROC-03 Sec.2.6]"
    fi
  else
    fail "$NAME - Auditing: Disabled (wajib aktif) [PROC-03 Sec.2.6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 6: Advanced Threat Protection (GOV-POL Area 8.3.4)
  #---------------------------------------------------------------------------
  ATP=$(az sql server advanced-threat-protection-setting show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  ATP_STATE=$(echo "$ATP" | jq -r '.state // "null"')
  if [ "$ATP_STATE" = "Enabled" ]; then
    pass "$NAME - Advanced Threat Protection: Enabled"
  else
    fail "$NAME - Advanced Threat Protection: Disabled [GOV-POL Area 8.3.4]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 7: Vulnerability Assessment (PROC-03 Sec.2.4)
  #---------------------------------------------------------------------------
  VA=$(az sql server va-setting show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  VA_STATE=$(echo "$VA" | jq -r '.state // "null"')
  if [ "$VA_STATE" = "Enabled" ]; then
    RECURRING=$(echo "$VA" | jq -r '.recurringScans.isEnabled // "null"')
    if [ "$RECURRING" = "true" ]; then
      pass "$NAME - Vulnerability Assessment: Enabled (recurring scans aktif)"
    else
      warn "$NAME - Vulnerability Assessment: Enabled tapi recurring scans disabled [PROC-03 Sec.2.4]"
    fi
  else
    fail "$NAME - Vulnerability Assessment: Disabled [PROC-03 Sec.2.4]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 8: Firewall Rules - Cek Allow Azure Services & wide ranges
  #---------------------------------------------------------------------------
  FW_RULES=$(az sql server firewall-rule list -s "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
  FW_COUNT=$(echo "$FW_RULES" | jq 'length')
  ALLOW_ALL=$(echo "$FW_RULES" | jq '[.[] | select(.startIpAddress=="0.0.0.0" and .endIpAddress=="255.255.255.255")] | length')
  ALLOW_AZURE=$(echo "$FW_RULES" | jq '[.[] | select(.startIpAddress=="0.0.0.0" and .endIpAddress=="0.0.0.0")] | length')

  if [ "$ALLOW_ALL" -gt 0 ] 2>/dev/null; then
    fail "$NAME - Firewall: Allow ALL IPs (0.0.0.0 - 255.255.255.255) [GOV-POL Area 8.3.3]"
  elif [ "$ALLOW_AZURE" -gt 0 ] 2>/dev/null; then
    warn "$NAME - Firewall: Allow Azure Services aktif ($FW_COUNT rules total)"
  elif [ "$FW_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Firewall: $FW_COUNT rules (restricted)"
  else
    pass "$NAME - Firewall: Tidak ada rules (kemungkinan hanya PE)"
  fi

  #---------------------------------------------------------------------------
  # CHECK 9: Private Endpoint (GOV-POL Area 8.3.3)
  #---------------------------------------------------------------------------
  PE_CONNS=$(echo "$SRV" | jq '[.privateEndpointConnections // [] | .[] | select(.properties.privateLinkServiceConnectionState.status=="Approved")] | length')
  if [ "$PE_CONNS" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Private Endpoint: $PE_CONNS koneksi aktif"
  else
    warn "$NAME - Private Endpoint: Tidak ada (disarankan untuk prod) [GOV-POL Area 8.3.3]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 10: Diagnostic Settings (PROC-03 Sec.2.6)
  #---------------------------------------------------------------------------
  RESOURCE_ID=$(echo "$SRV" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      warn "$NAME - Diagnostic Settings: Tidak ada [PROC-03 Sec.2.6]"
    fi
  fi

  #---------------------------------------------------------------------------
  # CHECK 11: Data Residency (PROC-09 Sec.2.3)
  #---------------------------------------------------------------------------
  LOCATION=$(echo "$SRV" | jq -r '.location // "null"')
  case "$LOCATION" in
    southeastasia|indonesiacentral)
      pass "$NAME - Data Residency: $LOCATION (diizinkan)"
      ;;
    *)
      warn "$NAME - Data Residency: $LOCATION (perlu justifikasi) [PROC-09 Sec.2.3]"
      ;;
  esac

  #---------------------------------------------------------------------------
  # 2b. Per-database checks (TDE, LTR, Geo-replication)
  #---------------------------------------------------------------------------
  DBS=$(az sql db list -s "$NAME" -g "$RG" --query "[?name!='master'].{name:name}" -o tsv 2>/dev/null || echo "")
  while IFS=$'\t' read -r DB_NAME; do
    [ -z "$DB_NAME" ] && continue
    log "  --- DB: [$DB_NAME] ---"

    # TDE (Transparent Data Encryption) - GOV-POL Area 5
    TDE=$(az sql db tde show -s "$NAME" -g "$RG" -d "$DB_NAME" -o json 2>/dev/null || echo "{}")
    TDE_STATE=$(echo "$TDE" | jq -r '.state // "null"')
    if [ "$TDE_STATE" = "Enabled" ]; then
      pass "  $DB_NAME - TDE (Encryption at-rest): Enabled"
    else
      fail "  $DB_NAME - TDE: Disabled (wajib aktif) [GOV-POL Area 5]"
    fi

    # Backup LTR (Long-Term Retention) - PROC-08, GOV-POL Area 10
    LTR=$(az sql db ltr-policy show -s "$NAME" -g "$RG" -n "$DB_NAME" -o json 2>/dev/null || echo "{}")
    LTR_WEEKLY=$(echo "$LTR" | jq -r '.weeklyRetention // "PT0S"')
    LTR_MONTHLY=$(echo "$LTR" | jq -r '.monthlyRetention // "PT0S"')
    LTR_YEARLY=$(echo "$LTR" | jq -r '.yearlyRetention // "PT0S"')

    if [ "$LTR_WEEKLY" != "PT0S" ] || [ "$LTR_MONTHLY" != "PT0S" ] || [ "$LTR_YEARLY" != "PT0S" ]; then
      pass "  $DB_NAME - LTR: W=$LTR_WEEKLY M=$LTR_MONTHLY Y=$LTR_YEARLY"
    else
      if echo "$NAME" | grep -qi "prod"; then
        warn "  $DB_NAME - LTR: Tidak dikonfigurasi (prod harus punya LTR) [PROC-08]"
      else
        info "  $DB_NAME - LTR: Tidak dikonfigurasi"
      fi
    fi

    # Geo-replication (PROC-08 Sec.2.3 - DR Strategy)
    GEO=$(az sql db replica list-links -s "$NAME" -g "$RG" -n "$DB_NAME" -o json 2>/dev/null || echo "[]")
    GEO_COUNT=$(echo "$GEO" | jq 'length')
    if [ "$GEO_COUNT" -gt 0 ] 2>/dev/null; then
      pass "  $DB_NAME - Geo-replication: $GEO_COUNT replica(s) aktif"
    else
      if echo "$NAME" | grep -qi "prod"; then
        warn "  $DB_NAME - Geo-replication: Tidak ada (pertimbangkan untuk DR) [PROC-08]"
      else
        info "  $DB_NAME - Geo-replication: Tidak ada"
      fi
    fi

  done <<< "$DBS"

  log ""
done <<< "$SERVERS"

###############################################################################
# 3. Failover Groups check (PROC-08 - DR)
###############################################################################
log "--- Failover Groups ---"
while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  FG=$(az sql failover-group list -s "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
  FG_COUNT=$(echo "$FG" | jq 'length')
  if [ "$FG_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Failover Group: $FG_COUNT group(s) aktif"
    echo "$FG" | jq '.[].name' -r | while read -r FG_NAME; do
      info "  Failover Group: $FG_NAME"
    done
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - Failover Group: Tidak ada (prod disarankan punya FG) [PROC-08 Sec.2.3]"
    else
      info "$NAME - Failover Group: Tidak ada"
    fi
  fi
done <<< "$SERVERS"
log ""

###############################################################################
# 4. Summary
###############################################################################
log "============================================================"
log "  RINGKASAN BENCHMARK SQL SERVER & DATABASE"
log "  PASS: $PASS | FAIL: $FAIL | WARN: $WARN | INFO: $INFO"
log "  Total checks: $((PASS+FAIL+WARN+INFO))"
log "============================================================"

echo ""
echo "Laporan disimpan: $REPORT"
echo "Data JSON: $JSON_DIR/sql-servers.json"
