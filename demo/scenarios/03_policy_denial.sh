#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 03: Policy Denial ---"

cat <<EOF > bad-cr.yaml
apiVersion: core.goldenpath.io/v1alpha1
kind: GoldenPath
metadata:
  name: badservice
  namespace: default
spec:
  owner: "team-backend"
EOF

# Give Kyverno a moment to register webhooks if it just started
sleep 2

# We expect this to fail and output DENY
OUTPUT=$(kubectl apply -f bad-cr.yaml 2>&1 || true)

if echo "$OUTPUT" | grep -q -E -i "deny|denied|blocked"; then
  echo "✅ Success: Kyverno correctly denied the resource."
else
  echo "❌ Error: Policy should have denied this, but it didn't!"
  echo "$OUTPUT"
  exit 1
fi

echo "✅ Success: Kyverno correctly denied the resource."
