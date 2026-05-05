#!/bin/bash
###############################################################################
# BENCHMARK: Azure Kubernetes Service (AKS)
# Referensi: GOV-POL Area 6 (IAM), Area 8 (Hardening, VAPT), Area 9 (Secure Dev)
#            GOV-POL Area 10 (BCP/DRP), PROC-03 Sec.2.4, PROC-08
###############################################################################

set -euo pipefail

SUBSCRIPTION="5b37e938-2a7d-4b6a-96b6-c2110cd12aaf"
OUTPUT_DIR="./output"
REPORT="$OUTPUT_DIR/benchmark-aks.txt"
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
log "  AZURE AKS SECURITY BENCHMARK"
log "  Tanggal: $TIMESTAMP"
log "============================================================"
log ""

az account set --subscription "$SUBSCRIPTION" 2>/dev/null

log "--- Enumerasi AKS Clusters ---"
az aks list --query "[].{name:name, rg:resourceGroup, location:location, kubernetesVersion:kubernetesVersion}" -o json > "$JSON_DIR/aks-clusters.json"
CLUSTERS=$(az aks list --query "[].{name:name, rg:resourceGroup}" -o tsv)
TOTAL=$(echo "$CLUSTERS" | grep -c "." || echo 0)
log "Total AKS Cluster: $TOTAL"
log ""

while IFS=$'\t' read -r NAME RG; do
  [ -z "$NAME" ] && continue
  log "=== [$NAME] (RG: $RG) ==="

  AKS=$(az aks show -n "$NAME" -g "$RG" -o json 2>/dev/null || echo "{}")

  # CHECK 1: Kubernetes Version (PROC-03 Sec.2.4 - Patch Management)
  K8S_VER=$(echo "$AKS" | jq -r '.kubernetesVersion // "null"')
  log "  Kubernetes Version: $K8S_VER"
  # Dapatkan versi terbaru yang tersedia
  LOCATION=$(echo "$AKS" | jq -r '.location // "southeastasia"')
  LATEST=$(az aks get-versions -l "$LOCATION" --query "values[?isDefault].version" -o tsv 2>/dev/null | head -1 || echo "unknown")
  if [ "$LATEST" != "unknown" ] && [ "$K8S_VER" = "$LATEST" ]; then
    pass "$NAME - K8s version: $K8S_VER (latest)"
  else
    warn "$NAME - K8s version: $K8S_VER (latest: $LATEST) [PROC-03 Sec.2.4]"
  fi

  # CHECK 2: Auto-upgrade Channel
  UPGRADE_CH=$(echo "$AKS" | jq -r '.autoUpgradeProfile.upgradeChannel // "none"')
  if [ "$UPGRADE_CH" != "none" ] && [ "$UPGRADE_CH" != "null" ]; then
    pass "$NAME - Auto-upgrade: $UPGRADE_CH"
  else
    warn "$NAME - Auto-upgrade: none (disarankan stable/patch) [PROC-03 Sec.2.4]"
  fi

  # CHECK 3: RBAC Enabled (GOV-POL Area 6)
  RBAC=$(echo "$AKS" | jq -r '.enableRbac // "null"')
  if [ "$RBAC" = "true" ]; then
    pass "$NAME - RBAC: Enabled"
  else
    fail "$NAME - RBAC: Disabled [GOV-POL Area 6]"
  fi

  # CHECK 4: Azure AD Integration
  AAD=$(echo "$AKS" | jq -r '.aadProfile.managed // "null"')
  if [ "$AAD" = "true" ]; then
    pass "$NAME - Azure AD Integration: Enabled"
  else
    warn "$NAME - Azure AD Integration: Disabled [GOV-POL Area 6]"
  fi

  # CHECK 5: Azure Policy Add-on (GOV-POL Area 9)
  POLICY=$(echo "$AKS" | jq -r '.addonProfiles.azurepolicy.enabled // "null"')
  if [ "$POLICY" = "true" ]; then
    pass "$NAME - Azure Policy Add-on: Enabled"
  else
    warn "$NAME - Azure Policy Add-on: Disabled (disarankan OPA Gatekeeper) [GOV-POL Area 9]"
  fi

  # CHECK 6: Network Policy (GOV-POL Area 8.3.3)
  NET_POLICY=$(echo "$AKS" | jq -r '.networkProfile.networkPolicy // "null"')
  if [ "$NET_POLICY" != "null" ] && [ "$NET_POLICY" != "" ]; then
    pass "$NAME - Network Policy: $NET_POLICY"
  else
    warn "$NAME - Network Policy: Tidak aktif [GOV-POL Area 8.3.3]"
  fi

  # CHECK 7: Authorized IP Ranges (API Server Access)
  AUTH_IP=$(echo "$AKS" | jq -r '.apiServerAccessProfile.authorizedIpRanges // [] | length')
  if [ "$AUTH_IP" -gt 0 ] 2>/dev/null; then
    pass "$NAME - API Server IP restriction: $AUTH_IP range(s)"
  else
    warn "$NAME - API Server: Open to all IPs [GOV-POL Area 8.3.3]"
  fi

  # CHECK 8: Private Cluster
  PRIVATE=$(echo "$AKS" | jq -r '.apiServerAccessProfile.enablePrivateCluster // "null"')
  if [ "$PRIVATE" = "true" ]; then
    pass "$NAME - Private Cluster: Enabled"
  else
    info "$NAME - Private Cluster: Disabled (public API server)"
  fi

  # CHECK 9: Defender for Containers / Security Profile
  DEFENDER=$(echo "$AKS" | jq -r '.securityProfile.defender.securityMonitoring.enabled // "null"')
  if [ "$DEFENDER" = "true" ]; then
    pass "$NAME - Defender for Containers: Enabled"
  else
    warn "$NAME - Defender for Containers: Disabled [GOV-POL Area 8.3.4]"
  fi

  # CHECK 10: Key Vault Secrets Provider
  KV_ADDON=$(echo "$AKS" | jq -r '.addonProfiles.azureKeyvaultSecretsProvider.enabled // "null"')
  if [ "$KV_ADDON" = "true" ]; then
    pass "$NAME - Key Vault Secrets Provider: Enabled"
  else
    warn "$NAME - Key Vault Secrets Provider: Disabled [GOV-POL Area 5.3.2]"
  fi

  # CHECK 11: Managed Identity
  IDENTITY=$(echo "$AKS" | jq -r '.identity.type // "None"')
  if [ "$IDENTITY" != "None" ] && [ "$IDENTITY" != "null" ]; then
    pass "$NAME - Managed Identity: $IDENTITY"
  else
    fail "$NAME - Managed Identity: Tidak aktif [GOV-POL Area 6]"
  fi

  # CHECK 12: Node Pool Availability Zones (PROC-08 - DR)
  ZONES=$(echo "$AKS" | jq -r '[.agentPoolProfiles[] | select(.availabilityZones != null and (.availabilityZones | length) > 0)] | length')
  TOTAL_POOLS=$(echo "$AKS" | jq -r '.agentPoolProfiles | length')
  if [ "$ZONES" -gt 0 ] 2>/dev/null; then
    pass "$NAME - Availability Zones: $ZONES/$TOTAL_POOLS pool(s) dengan AZ"
  else
    if echo "$NAME" | grep -qi "prod"; then
      warn "$NAME - Availability Zones: Tidak ada pool dengan AZ (prod disarankan) [PROC-08]"
    else
      info "$NAME - Availability Zones: Tidak ada"
    fi
  fi

  # CHECK 13: Diagnostic Settings
  RESOURCE_ID=$(echo "$AKS" | jq -r '.id // ""')
  if [ -n "$RESOURCE_ID" ]; then
    DIAG_COUNT=$(az monitor diagnostic-settings list --resource "$RESOURCE_ID" --query "length(value)" -o tsv 2>/dev/null || echo "0")
    if [ "$DIAG_COUNT" -gt 0 ] 2>/dev/null; then
      pass "$NAME - Diagnostic Settings: $DIAG_COUNT aktif"
    else
      fail "$NAME - Diagnostic Settings: Tidak ada [PROC-03 Sec.2.6]"
    fi
  fi

  log ""
done <<< "$CLUSTERS"

log "============================================================"
log "  RINGKASAN: PASS=$PASS | FAIL=$FAIL | WARN=$WARN | INFO=$INFO"
log "============================================================"
echo "Laporan: $REPORT"
