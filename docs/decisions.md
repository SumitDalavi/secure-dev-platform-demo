# Decisions

## ADR-001: Sequential Execution of Demo Stages
**Date:** 2026-08-29  
**Status:** Accepted

**Context:**  
The demo executes a script demonstrating multiple platform engineering tools (Kyverno, Admission Webhooks, Golden Path Provisioner, Secret Rotation) end-to-end. Race conditions can occur when policies are applied but not fully active before testing violation rules.

**Decision:**  
We will enforce sequential synchronization using `sleep` delays and `kubectl wait` in the Makefile between stages.

**Consequences:**  
- ✅ Positive outcome: Provides a stable, deterministic pipeline execution.
- ⚠️ Trade-off: Increases overall CI build duration.

## ADR-002: Multi-Tier Verification & OCI Dual Distribution
- **Context:** Declarative infrastructure and policy catalogs required robust local simulation gates without imposing cloud provider dependencies or credentials during CI/CD.
- **Decision:** Establish a strict 3-tier verification model (offline linting → sandbox cluster test → GitOps deployment) and distribute validated release packages with SBOMs and OCI container/chart registries.
- **Consequences:** 
  - *Pros:* Zero cloud credentials required for CI validation; verifiable supply-chain integrity via Syft SBOMs.
  - *Cons:* Requires maintaining local test fixtures and mock plan inputs.
