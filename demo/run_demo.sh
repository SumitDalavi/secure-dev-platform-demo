#!/usr/bin/env bash
set -euo pipefail

echo "=========================================="
echo "🚀 Running Secure Developer Platform Demo"
echo "=========================================="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"

echo "1. Scaffolding Service..."
bash "$SCRIPT_DIR/scenarios/01_scaffold_service.sh"
echo ""

echo "2. Testing Policy Denial (Missing Label)..."
bash "$SCRIPT_DIR/scenarios/03_policy_denial.sh"
echo ""

echo "3. Fixing Label and Applying CR..."
bash "$SCRIPT_DIR/scenarios/04_fix_and_admit.sh"
echo ""

echo "4. Checking Reconciliation (Namespace & RBAC)..."
bash "$SCRIPT_DIR/scenarios/05_reconcile_check.sh"
echo ""

echo "5. Triggering Secret Rotation..."
bash "$SCRIPT_DIR/scenarios/06_secret_rotation.sh"
echo ""

echo "✅ Demo completed successfully."
