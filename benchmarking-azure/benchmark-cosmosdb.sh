#!/bin/bash
###############################################################################
# BENCHMARK: Azure CosmosDB
# Referensi: GOV-POL Area 5 (Enkripsi), Area 8.3.3 (Network)
#            GOV-POL Area 10 (BCP/DRP), PROC-08, PROC-03 Sec.2.6
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-cosmosdb.txt"
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
log "  AZURE COSMOSDB SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi CosmosDB Accounts ---"
az cosmosdb list --query "[].{name:name, rg:resourceGroup, location:locations[0].locationName}" -o json > "$JSON_DIR/cosmosdb.json"
COSMOS_LIST=$(az cosmosdb list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$COSMOS_LIST" | grep -c "." || echo 0)
log "Total CosmosDB Accounts: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- [$NAME] (RG: $RG) ---"

  COSMOS=$(az cosmosdb show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Public Network Access
  PUBLIC=$(echo "$COSMOS" | jq -r '.publicNetworkAccess // "null"')
  if [ "$PUBLIC" = "Disabled" ]; then
    pass "$NAME - Public Network Access: Disabled"
  else
    warn "$NAME - Public Network Access: $PUBLIC [GOV-POL Area 8.3.3]"
  fi

  # CHECK 2: IP Firewall Rules
  IP_RULES=$(echo "$COSMOS" | jq -r '.ipRules | length')
  if [ "$IP_RULES" -gt 0 ] 2>/dev/null; then
    pass "$NAME - IP Firewall: $IP_RULES rule(s) aktif"
  else
    warn "$NAME - IP Firewall: Tidak ada rules [GOV-POL Area 8.3.3]"
  fi

  # CHECK 3: Virtual Network Filter
  VNET=$(echo "$COSMOS" | jq -r '.isVirtualNetworkFilterEnabled // "null"')
  if [ "$VNET" = "true" ]; then
    pass "$NAME - VNet Filter: Enabled"
  else
    info "$NAME - VNet Filter: Disabled"
  fi

  # CHECK 4: Private Endpoint
  PE_COUNT=$(echo "$COSMOS" | jq '[.privateEndpointConnections // [] | .[] | select(.properties.privateLinkServiceConnectionState.status=="Approved")] | length')
  if [ "$PE_COUNT" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Private Endpoint: $PE_COUNT aktif"
  else
    warn "$NAME - Private Endpoint: Tidak ada [GOV-POL Area 8.3.3]"
  fi

  # CHECK 5: Disable Key-based Metadata Write Access
  KEY_WRITE=$(echo "$COSMOS" | jq -r '.disableKeyBasedMetadataWriteAccess // "null"')
  if [ "$KEY_WRITE" = "true" ]; then
    pass "$NAME - Disable Key-based Write: true (hardened)"
  else
    info "$NAME - Disable Key-based Write: false"
  fi

  # CHECK 6: Backup Policy (PROC-08, GOV-POL Area 10)
  BACKUP_TYPE=$(echo "$COSMOS" | jq -r '.backupPolicy.type // "null"')
  if [ "$BACKUP_TYPE" = "Continuous" ]; then
    pass "$NAME - Backup Policy: Continuous (point-in-time restore)"
  elif [ "$BACKUP_TYPE" = "Periodic" ]; then
    INTERVAL=$(echo "$COSMOS" | jq -r '.backupPolicy.periodicModeProperties.backupIntervalInMinutes // "null"')
    RETENTION=$(echo "$COSMOS" | jq -r '.backupPolicy.periodicModeProperties.backupRetentionIntervalInHours // "null"')
    pass "$NAME - Backup Policy: Periodic (interval: ${INTERVAL}min, retensi: ${RETENTION}hr)"
  else
    fail "$NAME - Backup Policy: $BACKUP_TYPE [PROC-08]"
  fi

  # CHECK 7: Multi-region / Geo-redundancy (PROC-08)
  REGIONS=$(echo "$COSMOS" | jq '.locations | length')
  GEO_RED=$(echo "$COSMOS" | jq -r '.enableAutomaticFailover // "null"')
  if [ "$REGIONS" -gt 1 ] 2>/dev/null; then
    pass "$NAME - Multi-region: $REGIONS region(s), Auto-failover: $GEO_RED"
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - Single region ($REGIONS), auto-failover: $GEO_RED [PROC-08]"
    else
      info "$NAME - Single region ($REGIONS)"
    fi
  fi

  # CHECK 8: Minimum TLS
  MIN_TLS=$(echo "$COSMOS" | jq -r '.minimalTlsVersion // "null"')
  if [ "$MIN_TLS" = "Tls12" ] || [ "$MIN_TLS" = "1.2" ]; then
    pass "$NAME - TLS Minimum: $MIN_TLS"
  else
    warn "$NAME - TLS Minimum: $MIN_TLS (verifikasi >= 1.2) [GOV-POL Area 5]"
  fi

  # CHECK 9: Diagnostic Settings
  RESOURCE_ID=$(echo "$COSMOS" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      warn "$NAME - Diagnostic Settings: Tidak ada [PROC-03 Sec.2.6]"
    fi
  fi

  log ""
done <<< "$COSMOS_LIST"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
