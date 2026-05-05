#!/bin/bash
###############################################################################
# BENCHMARK: Azure App Service & Function App
# Referensi: GOV-POL Area 5 (Enkripsi), Area 8 (Hardening), Area 9 (Secure Dev)
#            PROC-03 Sec.2.2, Sec.2.6, Sec.2.8
# Subscription: AzureCSP_Pusaka
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-appservice.txt"
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
log "  AZURE APP SERVICE SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "  Subscription: $SUBSCRIPTION"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

###############################################################################
# 1. Enumerate semua App Services dan Function Apps
###############################################################################
log "--- Enumerasi App Service & Function App ---"
az webapp list --query "[].{name:name, rg:resourceGroup, kind:kind, state:state, location:location}" -o json > "$JSON_DIR/appservices.json"
APPS=$(az webapp list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$APPS" | grep -c "." || echo 0)
log "Total App Service/Function App ditemukan: $TOTAL"
log ""

###############################################################################
# 2. Per-app checks
###############################################################################
while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  # Ambil konfigurasi lengkap
  CONFIG=$(az webapp show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")
  SITE_CFG=$(az webapp config show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  #---------------------------------------------------------------------------
  # CHECK 1: HTTPS Only (GOV-POL Area 5 - Enkripsi in-transit)
  #---------------------------------------------------------------------------
  HTTPS_ONLY=$(echo "$CONFIG" | jq -r '.httpsOnly // "null"')
  if [ "$HTTPS_ONLY" = "true" ]; then
    pass "$NAME - HTTPS Only: Enabled"
  else
    fail "$NAME - HTTPS Only: Disabled (harus true) [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 2: Minimum TLS Version >= 1.2 (GOV-POL Area 5)
  #---------------------------------------------------------------------------
  MIN_TLS=$(echo "$SITE_CFG" | jq -r '.minTlsVersion // "null"')
  if [ "$MIN_TLS" = "1.2" ] || [ "$MIN_TLS" = "1.3" ]; then
    pass "$NAME - TLS Minimum: $MIN_TLS"
  else
    fail "$NAME - TLS Minimum: $MIN_TLS (harus >= 1.2) [GOV-POL Area 5]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 3: Remote Debugging Disabled (GOV-POL Area 8.3.1 - Hardening)
  #---------------------------------------------------------------------------
  REMOTE_DBG=$(echo "$SITE_CFG" | jq -r '.remoteDebuggingEnabled // "null"')
  if [ "$REMOTE_DBG" = "false" ] || [ "$REMOTE_DBG" = "null" ]; then
    pass "$NAME - Remote Debugging: Disabled"
  else
    fail "$NAME - Remote Debugging: ENABLED (harus disabled) [CIS Benchmark]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 4: FTP State (harus FtpsOnly atau Disabled)
  #---------------------------------------------------------------------------
  FTP_STATE=$(echo "$SITE_CFG" | jq -r '.ftpsState // "null"')
  if [ "$FTP_STATE" = "FtpsOnly" ] || [ "$FTP_STATE" = "Disabled" ]; then
    pass "$NAME - FTP State: $FTP_STATE"
  else
    fail "$NAME - FTP State: $FTP_STATE (harus FtpsOnly atau Disabled) [CIS Benchmark]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 5: Managed Identity (GOV-POL Area 6 - IAM, PROC-03 Sec.2.8)
  #---------------------------------------------------------------------------
  IDENTITY_TYPE=$(echo "$CONFIG" | jq -r '.identity.type // "None"')
  if [ "$IDENTITY_TYPE" != "None" ] && [ "$IDENTITY_TYPE" != "null" ]; then
    pass "$NAME - Managed Identity: $IDENTITY_TYPE"
  else
    warn "$NAME - Managed Identity: Tidak aktif (disarankan SystemAssigned) [GOV-POL Area 6]"
  fi

  #---------------------------------------------------------------------------
  # CHECK 6: HTTP/2 Enabled (CIS Azure Benchmark)
  #---------------------------------------------------------------------------
  HTTP2=$(echo "$SITE_CFG" | jq -r '.http20Enabled // "null"')
  if [ "$HTTP2" = "true" ]; then
    pass "$NAME - HTTP/2: Enabled"
  else
    warn "$NAME - HTTP/2: Disabled (disarankan enabled)"
  fi

  #---------------------------------------------------------------------------
  # CHECK 7: Always On (availability)
  #---------------------------------------------------------------------------
  ALWAYS_ON=$(echo "$SITE_CFG" | jq -r '.alwaysOn // "null"')
  if [ "$ALWAYS_ON" = "true" ]; then
    pass "$NAME - Always On: Enabled"
  else
    info "$NAME - Always On: Disabled"
  fi

  #---------------------------------------------------------------------------
  # CHECK 8: Client Certificate Mode (mTLS)
  #---------------------------------------------------------------------------
  CLIENT_CERT=$(echo "$CONFIG" | jq -r '.clientCertEnabled // "null"')
  if [ "$CLIENT_CERT" = "true" ]; then
    pass "$NAME - Client Cert (mTLS): Enabled"
  else
    info "$NAME - Client Cert (mTLS): Disabled"
  fi

  #---------------------------------------------------------------------------
  # CHECK 9: Diagnostic Settings (GOV-POL Area 8.3.6 - Logging)
  #---------------------------------------------------------------------------
  RESOURCE_ID=$(echo "$CONFIG" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT konfigurasi aktif"
    else
      fail "$NAME - Diagnostic Settings: Tidak ada (wajib untuk audit trail) [PROC-03 Sec.2.6]"
    fi
  fi

  log ""
done <<< "$APPS"

###############################################################################
# 3. Summary
###############################################################################
log "============================================================"
log "  RINGKASAN BENCHMARK APP SERVICE"
log "  PASS: $PASS | FAIL: $FAIL | WARN: $WARN | INFO: $INFO"
log "  Total checks: $((PASS+FAIL+WARN+INFO))"
log "============================================================"

echo ""
echo "Laporan disimpan: $REPORT"
echo "Data JSON: $JSON_DIR/appservices.json"
