#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 04: Fix and Admit ---"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
MANIFEST="manifests/golden-path-cr.yaml"
echo "Applying fixed CR from $MANIFEST..."
kubectl apply -f "$MANIFEST"
echo "✅ Applied successfully."
