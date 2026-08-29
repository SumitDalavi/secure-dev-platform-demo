#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 05: Reconcile Check ---"
echo "Checking if Golden Path Provisioner created the namespace and RBAC..."
kubectl get ns myservice-prod >/dev/null
echo "✅ Namespace created"
kubectl get rolebinding -n myservice-prod >/dev/null
echo "✅ RBAC RoleBinding created"
kubectl get resourcequota -n myservice-prod >/dev/null
echo "✅ ResourceQuota applied"
