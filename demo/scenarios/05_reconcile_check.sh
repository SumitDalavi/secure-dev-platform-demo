#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 05: Reconcile Check ---"
echo "Checking if Golden Path Provisioner created the namespace and RBAC..."
kubectl get pods -n default
kubectl logs -l app=golden-path --all-containers=true -n default || true
for i in {1..30}; do
  if kubectl get ns myservice-prod >/dev/null 2>&1; then
    break
  fi
  sleep 2
done
kubectl get ns myservice-prod >/dev/null
echo "✅ Namespace created"
kubectl get rolebinding -n myservice-prod >/dev/null
echo "✅ RBAC RoleBinding created"
kubectl get resourcequota -n myservice-prod >/dev/null
echo "✅ ResourceQuota applied"
