#!/usr/bin/env bash
set -euo pipefail

echo "--- Scenario 05: Reconcile Check ---"
echo "Checking if Golden Path Provisioner created the namespace and RBAC..."
kubectl.exe get pods -n default
kubectl.exe logs -l app=golden-path --all-containers=true -n default || true
sleep 5
kubectl.exe get ns myservice-prod >/dev/null
echo "✅ Namespace created"
kubectl.exe get rolebinding -n myservice-prod >/dev/null
echo "✅ RBAC RoleBinding created"
kubectl.exe get resourcequota -n myservice-prod >/dev/null
echo "✅ ResourceQuota applied"
