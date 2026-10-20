# Changelog

## [0.2.0] - 2026-10-20
### Added
- **Multi-Tier Verification:** Staged validation architecture (local static linting, sandbox cluster testing, GitOps production rollout).
- **Supply Chain Security:** Integrated Trivy vulnerability scanning, SPDX JSON SBOM generation, and SHA256 checksums on all release assets.
- **Developer Documentation:** Standardized 3-tier execution instructions and environment configuration templates (`.env.example`).

## [0.1.0] - 2026-10-18
### Added
- Initial catalog release with verified baseline policies, manifests, and automated CI pipelines.

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

## [v5.0.0] - 2026-08-30
### Added
- Upgraded to Portfolio V5 standards (World-Class).
- Added verifiable, reproducible E2E integration tests captured in run-history.
- Refined README.md presentation and architectural documentation.

### Fixed (Post-Release)
- Removed `.exe` extensions from Kubernetes CLI tools in scenario scripts and bootstrap to ensure compatibility with Linux-based GitHub Actions runners.


---

## [v0.1.0] — 2026-10-20
### Added
- **Release Automation:** Added `.github/workflows/release.yml` with automated catalog validation, tarball packaging, and SPDX SBOM generation.
- **Supply Chain Security:** Generated Anchore Syft SPDX JSON SBOM and cryptographic SHA-256 checksums.
- **Release Verification:** Added release verification documentation, badges, and operational runbook.
