#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 03: Policy Denial ---"
# Creating a dummy bad CR on the fly to simulate missing label
cat <<EOF | kubectl apply -f - 2>&1 | grep -q "DENY"
apiVersion: core.goldenpath.io/v1alpha1
kind: GoldenPath
metadata:
  name: badservice
  namespace: default
spec:
  owner: "team-backend"
EOF

echo "✅ Success: Kyverno correctly denied the resource."
