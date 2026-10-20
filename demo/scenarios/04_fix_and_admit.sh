#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 04: Fix and Admit ---"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
MANIFEST="manifests/golden-path-cr.yaml"
echo "Applying fixed CR from $MANIFEST..."
kubectl apply -f "$MANIFEST"
cat <<EOF | kubectl apply -f -
apiVersion: platform.example.com/v1alpha1
kind: PlatformService
metadata:
  name: myservice
  namespace: default
spec:
  team: backend
  tier: backend
EOF
echo "✅ Applied successfully."
