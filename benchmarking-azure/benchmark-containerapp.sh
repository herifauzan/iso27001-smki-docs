#!/bin/bash
###############################################################################
# BENCHMARK: Azure Container Apps
# Referensi: GOV-POL Area 5 (Enkripsi), Area 6 (IAM), Area 9 (Secure Dev)
#            PROC-03 Sec.2.8, PROC-09
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-containerapp.txt"
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
log "  AZURE CONTAINER APPS SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi Container Apps ---"
az containerapp list --query "[].{name:name, rg:resourceGroup, location:location}" -o json > "$JSON_DIR/container-apps.json" 2>/dev/null || echo "[]" > "$JSON_DIR/container-apps.json"
CA_LIST=$(az containerapp list --query "[].{name:name, rg:resourceGroup}" -o tsv 2>/dev/null || echo "")
TOTAL=$(echo "$CA_LIST" | grep -c "." || echo 0)
log "Total Container Apps: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  CA=$(az containerapp show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Ingress - HTTPS Only
  TRANSPORT=$(echo "$CA" | jq -r '.properties.configuration.ingress.transport // "null"')
  ALLOW_INSECURE=$(echo "$CA" | jq -r '.properties.configuration.ingress.allowInsecure // "null"')
  if [ "$ALLOW_INSECURE" = "false" ]; then
    pass "$NAME - HTTPS Only: Enabled (allowInsecure=false)"
  elif [ "$ALLOW_INSECURE" = "true" ]; then
    fail "$NAME - HTTPS Only: Disabled (allowInsecure=true) [GOV-POL Area 5]"
  else
    info "$NAME - Ingress: transport=$TRANSPORT"
  fi

  # CHECK 2: External Ingress (apakah terbuka publik)
  EXTERNAL=$(echo "$CA" | jq -r '.properties.configuration.ingress.external // "null"')
  if [ "$EXTERNAL" = "true" ]; then
    warn "$NAME - External Ingress: true (terbuka publik) [GOV-POL Area 8.3.3]"
  elif [ "$EXTERNAL" = "false" ]; then
    pass "$NAME - External Ingress: false (internal only)"
  else
    info "$NAME - Ingress: Tidak dikonfigurasi"
  fi

  # CHECK 3: Managed Identity (GOV-POL Area 6)
  IDENTITY=$(echo "$CA" | jq -r '.identity.type // "None"')
  if [ "$IDENTITY" != "None" ] && [ "$IDENTITY" != "null" ]; then
    pass "$NAME - Managed Identity: $IDENTITY"
  else
    warn "$NAME - Managed Identity: Tidak aktif [GOV-POL Area 6]"
  fi

  # CHECK 4: Image Source (private registry vs public)
  CONTAINERS=$(echo "$CA" | jq -r '.properties.template.containers // []')
  while IFS= read -r IMAGE; do
    [ -z "$IMAGE" ] && continue
    if echo "$IMAGE" | grep -qE "^(docker\.io|mcr\.microsoft\.com|ghcr\.io)"; then
      info "$NAME - Image: $IMAGE (public registry)"
    elif echo "$IMAGE" | grep -qE "\.azurecr\.io"; then
      pass "$NAME - Image: $IMAGE (private ACR)"
    else
      info "$NAME - Image: $IMAGE"
    fi
  done <<< "$(echo "$CONTAINERS" | jq -r '.[].image // empty')"

  # CHECK 5: Secrets Management (tidak boleh env var plaintext)
  SECRET_COUNT=$(echo "$CA" | jq '[.properties.configuration.secrets // [] | .[]] | length')
  if [ "$SECRET_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Secrets configured: $SECRET_COUNT secret(s)"
  else
    info "$NAME - No managed secrets configured"
  fi

  # CHECK 6: Scale Rules (availability)
  MIN_REPLICAS=$(echo "$CA" | jq -r '.properties.template.scale.minReplicas // 0')
  MAX_REPLICAS=$(echo "$CA" | jq -r '.properties.template.scale.maxReplicas // 0')
  info "$NAME - Scale: min=$MIN_REPLICAS, max=$MAX_REPLICAS"

  # CHECK 7: Data Residency (PROC-09)
  LOCATION=$(echo "$CA" | jq -r '.location // "null"')
  case "$LOCATION" in
    southeastasia|indonesiacentral|"Southeast Asia"|"Indonesia Central")
      pass "$NAME - Data Residency: $LOCATION" ;;
    *)
      warn "$NAME - Data Residency: $LOCATION (perlu justifikasi) [PROC-09]" ;;
  esac

  log ""
done <<< "$CA_LIST"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
