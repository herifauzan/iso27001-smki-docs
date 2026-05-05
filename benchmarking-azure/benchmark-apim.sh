#!/bin/bash
###############################################################################
# BENCHMARK: Azure API Management
# Referensi: GOV-POL Area 5 (Enkripsi), Area 8.3.3 (Network)
#            PROC-03 Sec.2.6, Sec.2.7
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-apim.txt"
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
log "  AZURE API MANAGEMENT SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

APIM_LIST=$(az apim list --query "[].{name:name, rg:resourceGroup}" -o tsv 2>/dev/null || echo "")
TOTAL=$(echo "$APIM_LIST" | grep -c "." || echo 0)
log "Total APIM: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"
  APIM=$(az apim show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # TLS 1.0 disabled
  TLS10=$(echo "$APIM" | jq -r '.customProperties["Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls10"] // "null"')
  [ "$TLS10" = "false" ] || [ "$TLS10" = "False" ] && pass "$NAME - TLS 1.0: Disabled" || fail "$NAME - TLS 1.0: Enabled [GOV-POL Area 5]"

  # TLS 1.1 disabled
  TLS11=$(echo "$APIM" | jq -r '.customProperties["Microsoft.WindowsAzure.ApiManagement.Gateway.Security.Protocols.Tls11"] // "null"')
  [ "$TLS11" = "false" ] || [ "$TLS11" = "False" ] && pass "$NAME - TLS 1.1: Disabled" || fail "$NAME - TLS 1.1: Enabled [GOV-POL Area 5]"

  # VNet
  VNET_TYPE=$(echo "$APIM" | jq -r '.virtualNetworkType // "None"')
  [ "$VNET_TYPE" != "None" ] && pass "$NAME - VNet: $VNET_TYPE" || warn "$NAME - VNet: None [GOV-POL Area 8.3.3]"

  # Managed Identity
  IDENTITY=$(echo "$APIM" | jq -r '.identity.type // "None"')
  [ "$IDENTITY" != "None" ] && pass "$NAME - Identity: $IDENTITY" || warn "$NAME - Identity: None [GOV-POL Area 6]"

  # Diagnostics
  RID=$(echo "$APIM" | jq -r '.id // ""')
  DC=$(az monitor diagnostic-settings list --resource "$RID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
  [ "$DC" -gt 0 ] 2>/dev/null && pass "$NAME - Diagnostics: $DC aktif" || warn "$NAME - Diagnostics: Tidak ada [PROC-03 Sec.2.6]"

  log ""
done <<< "$APIM_LIST"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
