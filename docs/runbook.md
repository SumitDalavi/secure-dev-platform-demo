# Runbook

## Running the Demo locally

1. Ensure you have a local Kubernetes cluster (like `kind` or `minikube`) running.
2. Install dependencies (e.g. `helm`, `kubectl`).
3. Build locally required images by running:
   ```bash
   make load-images
   ```
4. Run the full demo:
   ```bash
   make demo
   ```


---

## Release Runbook

### Release Trigger
Tag push matching `v*.*.*` (e.g., `v0.1.0`).

### Automated Pipeline Stages
1. **Quality & Validation Gate:** Validates policy syntax, manifest schemas, and configuration integrity.
2. **Distribution Packaging:** Bundles clean production manifests into `secure-dev-platform-demo-<tag>.tar.gz` and calculates SHA256 checksums.
3. **Syft Source SBOM:** Generates `sbom.spdx.json` adhering to SPDX 2.3 standard.
4. **GitHub Release:** Publishes release assets and release notes.

### Verification
```bash
gh release view v0.1.0 --repo SumitDalavi/secure-dev-platform-demo
gh release download v0.1.0 --repo SumitDalavi/secure-dev-platform-demo --pattern "checksums.txt"
```

### Failure Modes & Remediation
- **Linter / Test Failure:** Inspect policy syntax, configurations, or module arguments locally before tagging.
- **Checksum Mismatch:** Ensure file was completely downloaded without network truncation.
