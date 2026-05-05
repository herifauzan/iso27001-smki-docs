#!/bin/bash
###############################################################################
# BENCHMARK: Azure Network Security (NSG, VNet, Defender)
# Referensi: GOV-POL Area 8.3.3 (Network), PROC-03 Sec.2.7
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-network.txt"
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
log "  AZURE NETWORK SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

###############################################################################
# PART 1: NSG - Cek rule berbahaya (RDP/SSH open to internet)
###############################################################################
log "=== NSG RULES CHECK ==="
az network nsg list --query "[].{name:name, rg:resourceGroup}" -o json > "$JSON_DIR/nsgs.json"
NSGS=$(az network nsg list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL_NSG=$(echo "$NSGS" | grep -c "." || echo 0)
log "Total NSG: $TOTAL_NSG"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "--- NSG: [$NAME] ---"

  RULES=$(az network nsg rule list --nsg-name "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")

  # Cek RDP (3389) open to 0.0.0.0/0
  RDP_OPEN=$(echo "$RULES" | jq '[.[] | select(.access=="Allow" and .direction=="Inbound" and (.destinationPortRange=="3389" or .destinationPortRange=="*") and (.sourceAddressPrefix=="*" or .sourceAddressPrefix=="0.0.0.0/0" or .sourceAddressPrefix=="Internet"))] | length')
  if [ "$RDP_OPEN" -gt 0 ] 2>/dev/null; then
    fail "$NAME - RDP (3389) open to internet [GOV-POL Area 8.3.3]"
  else
    pass "$NAME - RDP (3389): Tidak open ke internet"
  fi

  # Cek SSH (22) open to 0.0.0.0/0
  SSH_OPEN=$(echo "$RULES" | jq '[.[] | select(.access=="Allow" and .direction=="Inbound" and (.destinationPortRange=="22" or .destinationPortRange=="*") and (.sourceAddressPrefix=="*" or .sourceAddressPrefix=="0.0.0.0/0" or .sourceAddressPrefix=="Internet"))] | length')
  if [ "$SSH_OPEN" -gt 0 ] 2>/dev/null; then
    fail "$NAME - SSH (22) open to internet [GOV-POL Area 8.3.3]"
  else
    pass "$NAME - SSH (22): Tidak open ke internet"
  fi

  # Cek All Ports open
  ALL_OPEN=$(echo "$RULES" | jq '[.[] | select(.access=="Allow" and .direction=="Inbound" and .destinationPortRange=="*" and (.sourceAddressPrefix=="*" or .sourceAddressPrefix=="0.0.0.0/0"))] | length')
  if [ "$ALL_OPEN" -gt 0 ] 2>/dev/null; then
    fail "$NAME - ALL PORTS open to internet [GOV-POL Area 8.3.3]"
  else
    pass "$NAME - No wildcard inbound from internet"
  fi

  log ""
done <<< "$NSGS"

###############################################################################
# PART 2: VNet Peering - Cek DEV-PROD segregation
###############################################################################
log "=== VNET PEERING CHECK ==="
VNETS=$(az network vnet list --query "[].{name:name, rg:resourceGroup}" -o tsv 2>/dev/null || echo "")
TOTAL_VNET=$(echo "$VNETS" | grep -c "." || echo 0)
log "Total VNet: $TOTAL_VNET"

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  PEERINGS=$(az network vnet peering list --vnet-name "$NAME" -g "$RG" -o json 2>/dev/null || echo "[]")
  PEER_COUNT=$(echo "$PEERINGS" | jq 'length')
  if [ "$PEER_COUNT" -gt 0 ] 2>/dev/null; then
    info "$NAME - $PEER_COUNT peering(s)"
    echo "$PEERINGS" | jq -r '.[].name' | while read -r PN; do
      info "  Peering: $PN"
    done
  else
    info "$NAME - No peering"
  fi
done <<< "$VNETS"
log ""

###############################################################################
# PART 3: Resource Locks pada resource kritis
###############################################################################
log "=== RESOURCE LOCKS CHECK ==="
LOCKS=$(az lock list --query "[].{name:name, level:level, notes:notes, id:id}" -o json 2>/dev/null || echo "[]")
LOCK_COUNT=$(echo "$LOCKS" | jq 'length')
if [ "$LOCK_COUNT" -gt 0 ] 2>/dev/null; then
  pass "Resource Locks: $LOCK_COUNT lock(s) aktif"
  echo "$LOCKS" | jq -r '.[] | "  [\(.level)] \(.name)"' | while read -r L; do
    info "$L"
  done
else
  warn "Resource Locks: Tidak ada lock pada subscription [GOV-POL Area 8.3.2]"
fi
log ""

###############################################################################
# PART 4: Defender for Cloud Pricing Tiers
###############################################################################
# log "=== DEFENDER FOR CLOUD ==="
# PRICING=$(az security pricing list -o json 2>/dev/null || echo "[]")
# echo "$PRICING" | jq -r '.[] | select(.name != null) | "\(.name): \(.pricingTier)"' | while read -r P; do
#   TIER=$(echo "$P" | cut -d: -f2 | xargs)
#   RESTYPE=$(echo "$P" | cut -d: -f1)
#   if [ "$TIER" = "Standard" ] || [ "$TIER" = "Free" ]; then
#     if [ "$TIER" = "Standard" ]; then
#       pass "Defender $RESTYPE: $TIER"
#     else
#       warn "Defender $RESTYPE: $TIER (disarankan Standard) [GOV-POL Area 8.3.4]"
#     fi
#   else
#     info "Defender $RESTYPE: $TIER"
#   fi
# done
# log ""

# log "============================================================"
# log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
# log "============================================================"
# echo "Laporan: $REPORT"
