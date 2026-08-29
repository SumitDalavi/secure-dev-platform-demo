# Changelog

## [2026-08-29] - Initial Setup and CI Fixes
### Added
- Created the repository for E2E platform demonstration.
- Added GitHub Actions CI pipeline (`.github/workflows/ci.yml`).
- Added standard documentation (`changelog.md`, `runbook.md`, `decisions.md`).
- Scaffolded missing `GoldenPath` CRD in `manifests/goldenpath-crd.yaml`.

### Fixed
- Fixed Kyverno policy denial demo script (`03_policy_denial.sh`) to safely evaluate exit codes without triggering `set -e` pipeline failures.
- Added a readiness wait step for `clusterpolicy/require-team-label` in the `Makefile` to prevent race conditions during the demo.
- Added `-R` flag to the secret rotation `kubectl apply` step in the `Makefile` so the CRD config in subdirectories gets deployed.
- Fixed `06_secret_rotation.sh` by accurately instantiating a `SecretRotation` CR before patching it, resolving API server errors.
