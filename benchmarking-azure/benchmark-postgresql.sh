#!/bin/bash
###############################################################################
# BENCHMARK: Azure Database for PostgreSQL (Flexible Server)
# Referensi: GOV-POL Area 5 (Enkripsi), Area 6 (IAM), Area 8 (Hardening)
#            GOV-POL Area 10 (BCP/DRP)
#            PROC-03 Sec.2.1 (Backup), Sec.2.4 (VAPT), Sec.2.6 (Audit)
#            PROC-08 Sec.2.3 (DR geo-redundancy)
# Subscription: AzureCSP_Pusaka
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-postgresql.txt"
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
log "  AZURE DATABASE FOR POSTGRESQL SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "  Subscription: $SUBSCRIPTION"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

###############################################################################
# 1. Enumerate semua PostgreSQL Flexible Servers
###############################################################################
log "--- Enumerasi PostgreSQL Flexible Servers ---"
az postgres flexible-server list --query "[].{name:name, rg:resourceGroup, location:location, fqdn:fullyQualifiedDomainName}" -o json > "$JSON_DIR/postgres-servers.json"
SERVERS=$(az postgres flexible-server list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$SERVERS" | grep -c "." || echo 0)
log "Total PostgreSQL Server ditemukan: $TOTAL"
log ""

###############################################################################
# 2. Per-server checks
###############################################################################
while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "=== POSTGRESQL SERVER: [$NAME] (RG: $RG) ==="

  SRV=$(az postgres flexible-server show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  #---------------------------------------------------------------------------
  # CHECK 1: Minimum TLS Version >= TLSv1.2 (GOV-POL Area 5)
  #---------------------------------------------------------------------------
  SSL_MIN=$(az postgres flexible-server parameter show -n ssl_min_protocol_version -s "$NAME" -g "$RG" --query value -o tsv 2>/dev/null || echo "unknown")
  if [ "$SSL_MIN" = "TLSv1.2" ] || [ "$SSL_MIN" = "TLSv1.3" ]; then
    pass "$NAME - TLS Minimum: $SSL_MIN"
  else
    fail "$NAME - TLS Minimum: $SSL_MIN (harus >= TLSv1.2) [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 2: Public Network Access (GOV-POL Area 8.3.3)
  #---------------------------------------------------------------------------
  PUBLIC_NET=$(echo "$SRV" | jq -r '.network.publicNetworkAccess // "null"')
  if [ "$PUBLIC_NET" = "Disabled" ]; then
    pass "$NAME - Public Network Access: Disabled"
  else
    warn "$NAME - Public Network Access: $PUBLIC_NET (disarankan Disabled, gunakan VNet Integration / PE) [GOV-POL Area 8.3.3]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 3: Azure AD (Entra ID) Authentication (GOV-POL Area 6)
  #---------------------------------------------------------------------------
  AAD_AUTH=$(echo "$SRV" | jq -r '.authConfig.activeDirectoryAuth // "null"')
  if [ "$AAD_AUTH" = "Enabled" ]; then
    pass "$NAME - Azure AD Auth: Enabled"
  else
    fail "$NAME - Azure AD Auth: Disabled [GOV-POL Area 6]"
  fi

  PWD_AUTH=$(echo "$SRV" | jq -r '.authConfig.passwordAuth // "null"')
  if [ "$PWD_AUTH" = "Disabled" ]; then
    pass "$NAME - Password Auth (Local): Disabled (AAD Only)"
  else
    warn "$NAME - Password Auth (Local): Enabled (Disarankan Disabled jika memungkinkan) [GOV-POL Area 6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 4: Azure AD Admin Configured
  #---------------------------------------------------------------------------
  AAD_ADMINS=$(az postgres flexible-server ad-admin list -s "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
  ADMIN_COUNT=$(echo "$AAD_ADMINS" | jq 'length')
  if [ "$ADMIN_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Azure AD Admin: $ADMIN_COUNT dikonfigurasi"
  else
    fail "$NAME - Azure AD Admin: Tidak ada [GOV-POL Area 6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 5: Auditing via pgAudit (PROC-03 Sec.2.6)
  #---------------------------------------------------------------------------
  PGAUDIT=$(az postgres flexible-server parameter show -n azure.extensions -s "$NAME" -g "$RG" --query value -o tsv 2>/dev/null || echo "")
  if echo "$PGAUDIT" | grep -qi "pgaudit"; then
    pass "$NAME - Extension pgaudit: Enabled"
  else
    fail "$NAME - Extension pgaudit: Disabled (wajib untuk auditing) [PROC-03 Sec.2.6]"
  fi

  LOG_COLLECTOR=$(az postgres flexible-server parameter show -n logging_collector -s "$NAME" -g "$RG" --query value -o tsv 2>/dev/null || echo "unknown")
  if [ "$LOG_COLLECTOR" = "on" ] || [ "$LOG_COLLECTOR" = "ON" ]; then
    pass "$NAME - Parameter logging_collector: on"
  else
    fail "$NAME - Parameter logging_collector: $LOG_COLLECTOR (harus on) [PROC-03 Sec.2.6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 6: Advanced Threat Protection (GOV-POL Area 8.3.4)
  #---------------------------------------------------------------------------
  ATP=$(az postgres flexible-server advanced-threat-protection-setting show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  ATP_STATE=$(echo "$ATP" | jq -r '.state // "null"')
  if [ "$ATP_STATE" = "Enabled" ]; then
    pass "$NAME - Advanced Threat Protection: Enabled"
  else
    fail "$NAME - Advanced Threat Protection: Disabled [GOV-POL Area 8.3.4]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 7: Firewall Rules
  #---------------------------------------------------------------------------
  FW_RULES=$(az postgres flexible-server firewall-rule list -s "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
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
    pass "$NAME - Firewall: Tidak ada rules (kemungkinan VNet/PE)"
  fi

  #---------------------------------------------------------------------------
  # CHECK 8: Diagnostic Settings (PROC-03 Sec.2.6)
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
  # CHECK 9: Backup Retention & Geo-Redundancy (PROC-03 Sec.2.1, PROC-08)
  #---------------------------------------------------------------------------
  GEO_BACKUP=$(echo "$SRV" | jq -r '.backup.geoRedundantBackup // "null"')
  BACKUP_RETENTION=$(echo "$SRV" | jq -r '.backup.backupRetentionDays // 0')
  
  if [ "$GEO_BACKUP" = "Enabled" ]; then
    pass "$NAME - Geo-Redundant Backup: Enabled"
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - Geo-Redundant Backup: Disabled (prod disarankan aktif untuk DR) [PROC-08]"
    else
      info "$NAME - Geo-Redundant Backup: Disabled"
    fi
  fi

  if [ "$BACKUP_RETENTION" -ge 30 ] 2>/dev/null; then
    pass "$NAME - Backup Retention: $BACKUP_RETENTION hari"
  else
    warn "$NAME - Backup Retention: $BACKUP_RETENTION hari (disarankan min. 30 hari) [PROC-03 Sec.2.1]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 10: High Availability (Zone Redundancy) (PROC-08)
  #---------------------------------------------------------------------------
  HA_MODE=$(echo "$SRV" | jq -r '.highAvailability.mode // "null"')
  if [ "$HA_MODE" = "ZoneRedundant" ] || [ "$HA_MODE" = "SameZone" ]; then
    pass "$NAME - High Availability: $HA_MODE"
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - High Availability: $HA_MODE (prod disarankan ZoneRedundant) [PROC-08]"
    else
      info "$NAME - High Availability: $HA_MODE"
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

  log ""
done <<< "$SERVERS"

###############################################################################
# 3. Summary
###############################################################################
log "============================================================"
log "  RINGKASAN BENCHMARK POSTGRESQL (FLEXIBLE SERVER)"
log "  PASS: $PASS | FAIL: $FAIL | WARN: $WARN | INFO: $INFO"
log "  Total checks: $((PASS+FAIL+WARN+INFO))"
log "============================================================"

echo ""
echo "Laporan disimpan: $REPORT"
echo "Data JSON: $JSON_DIR/postgres-servers.json"
