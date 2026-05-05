#!/bin/bash
###############################################################################
# BENCHMARK: Azure Container Registry (ACR)
# Referensi: GOV-POL Area 6 (IAM), Area 8 (Vuln Scanning), Area 9 (Secure Dev)
#            PROC-03 Sec.2.4, Sec.2.8
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-acr.txt"
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
log "  AZURE CONTAINER REGISTRY SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi Container Registries ---"
az acr list --query "[].{name:name, rg:resourceGroup, location:location, sku:sku.name}" -o json > "$JSON_DIR/container-registries.json"
ACRS=$(az acr list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$ACRS" | grep -c "." || echo 0)
log "Total ACR: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  ACR=$(az acr show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Admin User Disabled (GOV-POL Area 6 - IAM)
  ADMIN=$(echo "$ACR" | jq -r '.adminUserEnabled // "null"')
  if [ "$ADMIN" = "false" ]; then
    pass "$NAME - Admin User: Disabled"
  else
    fail "$NAME - Admin User: ENABLED (harus disabled, gunakan Managed Identity) [GOV-POL Area 6]"
  fi

  # CHECK 2: SKU (Premium diperlukan untuk PE, geo-repl, content trust)
  SKU=$(echo "$ACR" | jq -r '.sku.name // "null"')
  info "$NAME - SKU: $SKU"
  if [ "$SKU" != "Premium" ]; then
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - SKU: $SKU (prod disarankan Premium untuk fitur security) [Best Practice]"
    fi
  fi

  # CHECK 3: Public Network Access
  PUBLIC=$(echo "$ACR" | jq -r '.publicNetworkAccess // "null"')
  if [ "$PUBLIC" = "Disabled" ]; then
    pass "$NAME - Public Network Access: Disabled"
  else
    warn "$NAME - Public Network Access: $PUBLIC [GOV-POL Area 8.3.3]"
  fi

  # CHECK 4: Network Rule Default Action
  NET_DEFAULT=$(echo "$ACR" | jq -r '.networkRuleSet.defaultAction // "null"')
  if [ "$NET_DEFAULT" = "Deny" ]; then
    pass "$NAME - Network Default Action: Deny"
  elif [ "$SKU" = "Premium" ]; then
    warn "$NAME - Network Default Action: $NET_DEFAULT (Premium harus restrict) [GOV-POL Area 8.3.3]"
  else
    info "$NAME - Network Default Action: $NET_DEFAULT (non-Premium)"
  fi

  # CHECK 5: Content Trust (image signing)
  CONTENT_TRUST=$(echo "$ACR" | jq -r '.policies.trustPolicy.status // "null"')
  if [ "$CONTENT_TRUST" = "enabled" ]; then
    pass "$NAME - Content Trust: Enabled"
  else
    info "$NAME - Content Trust: Disabled (opsional)"
  fi

  # CHECK 6: Quarantine Policy
  QUARANTINE=$(echo "$ACR" | jq -r '.policies.quarantinePolicy.status // "null"')
  if [ "$QUARANTINE" = "enabled" ]; then
    pass "$NAME - Quarantine Policy: Enabled"
  else
    info "$NAME - Quarantine Policy: Disabled"
  fi

  # CHECK 7: Retention Policy (cleanup untagged images)
  RETENTION=$(echo "$ACR" | jq -r '.policies.retentionPolicy.status // "null"')
  RET_DAYS=$(echo "$ACR" | jq -r '.policies.retentionPolicy.days // 0')
  if [ "$RETENTION" = "enabled" ]; then
    pass "$NAME - Retention Policy: Enabled ($RET_DAYS hari)"
  else
    warn "$NAME - Retention Policy: Disabled (disarankan untuk cleanup) [Best Practice]"
  fi

  # CHECK 8: Encryption (Customer-Managed Key)
  ENC_STATUS=$(echo "$ACR" | jq -r '.encryption.status // "null"')
  if [ "$ENC_STATUS" = "enabled" ]; then
    pass "$NAME - Encryption (CMK): Enabled"
  else
    info "$NAME - Encryption: Platform-managed (default)"
  fi

  # CHECK 9: Zone Redundancy (PROC-08)
  ZONE_RED=$(echo "$ACR" | jq -r '.zoneRedundancy // "null"')
  if [ "$ZONE_RED" = "Enabled" ]; then
    pass "$NAME - Zone Redundancy: Enabled"
  else
    info "$NAME - Zone Redundancy: Disabled"
  fi

  # CHECK 10: Diagnostic Settings
  RESOURCE_ID=$(echo "$ACR" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      warn "$NAME - Diagnostic Settings: Tidak ada [PROC-03 Sec.2.6]"
    fi
  fi

  log ""
done <<< "$ACRS"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
