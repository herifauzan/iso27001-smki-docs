#!/bin/bash
###############################################################################
# BENCHMARK: Azure Key Vault
# Referensi: GOV-POL Area 5.3.2 (Secrets/Encryption), Area 6 (IAM)
#            GOV-POL Area 8.3.6 (Audit Trail), PROC-03 Sec.2.6
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-keyvault.txt"
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
log "  AZURE KEY VAULT SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi Key Vaults ---"
az keyvault list --query "[].{name:name, rg:resourceGroup, location:location}" -o json > "$JSON_DIR/key-vaults.json"
KVS=$(az keyvault list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$KVS" | grep -c "." || echo 0)
log "Total Key Vault: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  KV=$(az keyvault show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Soft Delete
  SOFT_DEL=$(echo "$KV" | jq -r '.properties.enableSoftDelete // "null"')
  if [ "$SOFT_DEL" = "true" ]; then
    SOFT_DAYS=$(echo "$KV" | jq -r '.properties.softDeleteRetentionInDays // 0')
    pass "$NAME - Soft Delete: Enabled ($SOFT_DAYS hari)"
  else
    fail "$NAME - Soft Delete: Disabled [GOV-POL Area 5.3.2]"
  fi

  # CHECK 2: Purge Protection
  PURGE=$(echo "$KV" | jq -r '.properties.enablePurgeProtection // "null"')
  if [ "$PURGE" = "true" ]; then
    pass "$NAME - Purge Protection: Enabled"
  else
    fail "$NAME - Purge Protection: Disabled [GOV-POL Area 5.3.2]"
  fi

  # CHECK 3: RBAC Authorization (vs legacy Access Policy)
  RBAC=$(echo "$KV" | jq -r '.properties.enableRbacAuthorization // "null"')
  if [ "$RBAC" = "true" ]; then
    pass "$NAME - Authorization: RBAC model"
  else
    warn "$NAME - Authorization: Access Policy model (disarankan RBAC) [GOV-POL Area 6]"
  fi

  # CHECK 4: Network ACL
  NET_DEFAULT=$(echo "$KV" | jq -r '.properties.networkAcls.defaultAction // "null"')
  if [ "$NET_DEFAULT" = "Deny" ]; then
    pass "$NAME - Network ACL: Deny (restricted)"
  else
    warn "$NAME - Network ACL: $NET_DEFAULT (disarankan Deny) [GOV-POL Area 8.3.3]"
  fi

  # CHECK 5: Private Endpoint
  PE_COUNT=$(echo "$KV" | jq '[.properties.privateEndpointConnections // [] | .[] | select(.properties.privateLinkServiceConnectionState.status=="Approved")] | length')
  if [ "$PE_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Private Endpoint: $PE_COUNT aktif"
  else
    info "$NAME - Private Endpoint: Tidak ada"
  fi

  # CHECK 6: Diagnostic Settings
  RESOURCE_ID=$(echo "$KV" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      fail "$NAME - Diagnostic Settings: Tidak ada (wajib untuk audit) [PROC-03 Sec.2.6]"
    fi
  fi

  # CHECK 7: Expired Secrets
  SECRETS=$(az keyvault secret list --vault-name "$NAME" --query "[].{name:name, enabled:attributes.enabled, expires:attributes.expires}" -o json 2>/dev/null || echo "[]")
  EXPIRED=$(echo "$SECRETS" | jq --arg now "$(date -u +%Y-%m-%dT%H:%M:%SZ)" '[.[] | select(.expires != null and .expires < $now and .enabled == true)] | length')
  NO_EXPIRY=$(echo "$SECRETS" | jq '[.[] | select(.expires == null and .enabled == true)] | length')
  TOTAL_SEC=$(echo "$SECRETS" | jq 'length')

  if [ "$EXPIRED" -gt 0 ] 2>/dev/null; then
    fail "$NAME - Expired Secrets: $EXPIRED secret(s) expired [GOV-POL Area 8.3.1]"
  else
    pass "$NAME - Expired Secrets: Tidak ada"
  fi

  if [ "$NO_EXPIRY" -gt 0 ] 2>/dev/null; then
    warn "$NAME - Secrets tanpa expiry date: $NO_EXPIRY dari $TOTAL_SEC [GOV-POL Area 8.3.1]"
  else
    pass "$NAME - Semua secrets memiliki expiry date"
  fi

  # CHECK 8: Data Residency
  LOCATION=$(echo "$KV" | jq -r '.location // "null"')
  case "$LOCATION" in
    southeastasia|indonesiacentral)
      pass "$NAME - Data Residency: $LOCATION" ;;
    *)
      warn "$NAME - Data Residency: $LOCATION (perlu justifikasi) [PROC-09]" ;;
  esac

  log ""
done <<< "$KVS"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
