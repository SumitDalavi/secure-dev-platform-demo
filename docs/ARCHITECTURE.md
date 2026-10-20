# secure-dev-platform-demo Architecture

## Verification & Deployment Architecture (v0.2.0)

This repository follows a progressive verification architecture designed for zero-trust cloud native environments:

```mermaid
graph TD
    A[Local Authoring] -->|Static Lint & Schema Validation| B[Tier 1: Offline Gate]
    B -->|Kind / Sandbox Cluster Apply| C[Tier 2: Emulation Sandbox]
    C -->|GitOps PR & Merge| D[Tier 3: Production GitOps]
    D --> E[Live Cluster / Cloud State]
```

- **Tier 1 (Offline Validation):** Syntax validation, static policy checks (`opa test`, `kyverno test`, `terraform fmt -check`), and schema verification without cloud dependencies.
- **Tier 2 (Sandbox Emulation):** Automated testing against local Kind clusters or isolated development namespaces.
- **Tier 3 (Production GitOps):** Automated deployment via GitOps controllers (ArgoCD / Flux) or infrastructure pipelines with cryptographically signed release manifests and SPDX SBOMs.
