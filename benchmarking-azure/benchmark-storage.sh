#!/bin/bash
###############################################################################
# BENCHMARK: Azure Storage Account
# Referensi: GOV-POL Area 5 (Enkripsi, Data Protection, Cloud Data Security)
#            GOV-POL Area 8.3.3 (Network Security)
#            GOV-POL Area 10 (Backup/DR), PROC-08, PROC-09
#            PROC-03 Sec.2.2, Sec.2.6
# Subscription: AzureCSP_Pusaka
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-storage.txt"
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
log "  AZURE STORAGE ACCOUNT SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "  Subscription: $SUBSCRIPTION"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

###############################################################################
# 1. Enumerate semua Storage Accounts
###############################################################################
log "--- Enumerasi Storage Accounts ---"
az storage account list --query "[].{name:name, rg:resourceGroup, location:location, kind:kind, sku:sku.name}" -o json > "$JSON_DIR/storage-accounts.json"
STORAGES=$(az storage account list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$STORAGES" | grep -c "." || echo 0)
log "Total Storage Account ditemukan: $TOTAL"
log ""

###############################################################################
# 2. Per-storage checks
###############################################################################
while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  SA=$(az storage account show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  #---------------------------------------------------------------------------
  # CHECK 1: HTTPS Only (GOV-POL Area 5 - Enkripsi in-transit)
  #---------------------------------------------------------------------------
  HTTPS_ONLY=$(echo "$SA" | jq -r '.enableHttpsTrafficOnly // "null"')
  if [ "$HTTPS_ONLY" = "true" ]; then
    pass "$NAME - HTTPS Only: Enabled"
  else
    fail "$NAME - HTTPS Only: Disabled [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 2: Minimum TLS Version >= 1.2 (GOV-POL Area 5)
  #---------------------------------------------------------------------------
  MIN_TLS=$(echo "$SA" | jq -r '.minimumTlsVersion // "null"')
  if [ "$MIN_TLS" = "TLS1_2" ] || [ "$MIN_TLS" = "TLS1_3" ]; then
    pass "$NAME - TLS Minimum: $MIN_TLS"
  else
    fail "$NAME - TLS Minimum: $MIN_TLS (harus TLS1_2+) [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 3: Encryption at-rest (AES-256, GOV-POL Area 5)
  #---------------------------------------------------------------------------
  ENC_SVC=$(echo "$SA" | jq -r '.encryption.services.blob.enabled // "null"')
  ENC_KEY=$(echo "$SA" | jq -r '.encryption.keySource // "null"')
  if [ "$ENC_SVC" = "true" ]; then
    pass "$NAME - Encryption at-rest: Enabled (keySource: $ENC_KEY)"
  else
    fail "$NAME - Encryption at-rest: Disabled [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 4: Public Blob Access (GOV-POL Area 8.3.3 - Network)
  #---------------------------------------------------------------------------
  PUBLIC_BLOB=$(echo "$SA" | jq -r '.allowBlobPublicAccess // "null"')
  if [ "$PUBLIC_BLOB" = "false" ] || [ "$PUBLIC_BLOB" = "null" ]; then
    pass "$NAME - Public Blob Access: Disabled"
  else
    fail "$NAME - Public Blob Access: ENABLED (harus disabled) [GOV-POL Area 8.3.3]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 5: Network Default Action (GOV-POL Area 8.3.3)
  #---------------------------------------------------------------------------
  NET_DEFAULT=$(echo "$SA" | jq -r '.networkRuleSet.defaultAction // "null"')
  if [ "$NET_DEFAULT" = "Deny" ]; then
    pass "$NAME - Network Default Action: Deny (restricted)"
  else
    warn "$NAME - Network Default Action: $NET_DEFAULT (disarankan Deny) [GOV-POL Area 8.3.3]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 6: Shared Key Access (disarankan disabled, gunakan Entra ID)
  #---------------------------------------------------------------------------
  SHARED_KEY=$(echo "$SA" | jq -r '.allowSharedKeyAccess // "null"')
  if [ "$SHARED_KEY" = "false" ]; then
    pass "$NAME - Shared Key Access: Disabled (menggunakan Entra ID)"
  else
    info "$NAME - Shared Key Access: Enabled (pertimbangkan disable untuk security)"
  fi

  #---------------------------------------------------------------------------
  # CHECK 7: Geo-redundancy / Replication (PROC-08, GOV-POL Area 10)
  #---------------------------------------------------------------------------
  SKU=$(echo "$SA" | jq -r '.sku.name // "null"')
  case "$SKU" in
    *GRS*|*GZRS*|*RAGRS*|*RAGZRS*)
      pass "$NAME - Replication: $SKU (geo-redundant)"
      ;;
    *LRS*|*ZRS*)
      # Cek apakah ini prod storage
      if echo "$NAME" | grep -qi "prod"; then
        warn "$NAME - Replication: $SKU (prod resource tanpa geo-redundancy) [PROC-08]"
      else
        info "$NAME - Replication: $SKU (locally redundant)"
      fi
      ;;
    *)
      info "$NAME - Replication: $SKU"
      ;;
  esac

  #---------------------------------------------------------------------------
  # CHECK 8: Soft Delete for Blobs (data protection)
  #---------------------------------------------------------------------------
  BLOB_PROPS=$(az storage account blob-service-properties show --account-name "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  SOFT_DEL=$(echo "$BLOB_PROPS" | jq -r '.deleteRetentionPolicy.enabled // "null"')
  SOFT_DAYS=$(echo "$BLOB_PROPS" | jq -r '.deleteRetentionPolicy.days // 0')
  if [ "$SOFT_DEL" = "true" ]; then
    pass "$NAME - Blob Soft Delete: Enabled ($SOFT_DAYS hari)"
  else
    warn "$NAME - Blob Soft Delete: Disabled (disarankan aktif)"
  fi

  #---------------------------------------------------------------------------
  # CHECK 9: Container Soft Delete
  #---------------------------------------------------------------------------
  CONT_SOFT=$(echo "$BLOB_PROPS" | jq -r '.containerDeleteRetentionPolicy.enabled // "null"')
  CONT_DAYS=$(echo "$BLOB_PROPS" | jq -r '.containerDeleteRetentionPolicy.days // 0')
  if [ "$CONT_SOFT" = "true" ]; then
    pass "$NAME - Container Soft Delete: Enabled ($CONT_DAYS hari)"
  else
    warn "$NAME - Container Soft Delete: Disabled"
  fi

  #---------------------------------------------------------------------------
  # CHECK 10: Diagnostic Settings (PROC-03 Sec.2.6 - Audit Trail)
  #---------------------------------------------------------------------------
  RESOURCE_ID=$(echo "$SA" | jq -r '.id // ""')
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
  LOCATION=$(echo "$SA" | jq -r '.location // "null"')
  case "$LOCATION" in
    southeastasia|indonesiacentral)
      pass "$NAME - Data Residency: $LOCATION (diizinkan)"
      ;;
    *)
      warn "$NAME - Data Residency: $LOCATION (perlu justifikasi) [PROC-09 Sec.2.3]"
      ;;
  esac

  log ""
done <<< "$STORAGES"

###############################################################################
# 3. Summary
###############################################################################
log "============================================================"
log "  RINGKASAN BENCHMARK STORAGE ACCOUNT"
log "  PASS: $PASS | FAIL: $FAIL | WARN: $WARN | INFO: $INFO"
log "  Total checks: $((PASS+FAIL+WARN+INFO))"
log "============================================================"

echo ""
echo "Laporan disimpan: $REPORT"
echo "Data JSON: $JSON_DIR/storage-accounts.json"
