#!/bin/bash
###############################################################################
# BENCHMARK: Azure Cache for Redis
# Referensi: GOV-POL Area 5 (Enkripsi), Area 8.3.3 (Network)
#            GOV-POL Area 10 (DR), PROC-08, PROC-03 Sec.2.6
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-redis.txt"
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
log "  AZURE CACHE FOR REDIS SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi Redis ---"
az redis list --query "[].{name:name, rg:resourceGroup, location:location, sku:sku.name}" -o json > "$JSON_DIR/redis.json"
REDIS_LIST=$(az redis list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$REDIS_LIST" | grep -c "." || echo 0)
log "Total Redis Cache: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  REDIS=$(az redis show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Minimum TLS Version (GOV-POL Area 5)
  MIN_TLS=$(echo "$REDIS" | jq -r '.minimumTlsVersion // "null"')
  if [ "$MIN_TLS" = "1.2" ] || [ "$MIN_TLS" = "1.3" ]; then
    pass "$NAME - TLS Minimum: $MIN_TLS"
  else
    fail "$NAME - TLS Minimum: $MIN_TLS (harus >= 1.2) [GOV-POL Area 5]"
  fi

  # CHECK 2: Non-SSL Port Disabled (port 6379)
  NON_SSL=$(echo "$REDIS" | jq -r '.enableNonSslPort // "null"')
  if [ "$NON_SSL" = "false" ]; then
    pass "$NAME - Non-SSL Port (6379): Disabled"
  else
    fail "$NAME - Non-SSL Port (6379): ENABLED (harus disabled) [GOV-POL Area 5]"
  fi

  # CHECK 3: Public Network Access
  PUBLIC=$(echo "$REDIS" | jq -r '.publicNetworkAccess // "null"')
  if [ "$PUBLIC" = "Disabled" ]; then
    pass "$NAME - Public Network Access: Disabled"
  else
    warn "$NAME - Public Network Access: $PUBLIC [GOV-POL Area 8.3.3]"
  fi

  # CHECK 4: Private Endpoint
  PE_COUNT=$(echo "$REDIS" | jq '[.privateEndpointConnections // [] | .[] | select(.privateLinkServiceConnectionState.status=="Approved")] | length')
  if [ "$PE_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Private Endpoint: $PE_COUNT aktif"
  else
    warn "$NAME - Private Endpoint: Tidak ada [GOV-POL Area 8.3.3]"
  fi

  # CHECK 5: SKU & Persistence (PROC-08 - DR)
  SKU=$(echo "$REDIS" | jq -r '.sku.name // "null"')
  info "$NAME - SKU: $SKU"

  if [ "$SKU" = "Premium" ]; then
    # Cek RDB persistence
    RDB=$(echo "$REDIS" | jq -r '.redisConfiguration."rdb-backup-enabled" // "null"')
    if [ "$RDB" = "true" ]; then
      pass "$NAME - RDB Persistence: Enabled"
    else
      warn "$NAME - RDB Persistence: Disabled (Premium tapi tanpa persistence) [PROC-08]"
    fi
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - SKU: $SKU (prod disarankan Premium untuk persistence/geo-repl) [PROC-08]"
    fi
  fi

  # CHECK 6: Firewall Rules
  FW=$(az redis firewall-rules list -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
  FW_COUNT=$(echo "$FW" | jq 'length')
  if [ "$FW_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Firewall Rules: $FW_COUNT rule(s) aktif"
  else
    info "$NAME - Firewall Rules: Tidak ada (kemungkinan PE only)"
  fi

  # CHECK 7: Diagnostic Settings
  RESOURCE_ID=$(echo "$REDIS" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      warn "$NAME - Diagnostic Settings: Tidak ada [PROC-03 Sec.2.6]"
    fi
  fi

  log ""
done <<< "$REDIS_LIST"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
