# Secure Dev Platform

> **Maturity:** Functional Prototype

This composition ties together the Golden Path Provisioner, Admission Webhooks, Secret Rotation Operator, and Kyverno Policies into a single end-to-end integration demo demonstrating a secure, self-service developer platform.

## Prerequisites
- Docker
- Kubernetes CLI (`kubectl`)
- Helm
- kind (Kubernetes IN Docker)
- GNU Make

## Startup and Teardown
To run the demo locally, use the provided `Makefile`:

```bash
make up          # Spins up the Kind cluster, builds images, and deploys all operators and policies
make demo        # Runs the end-to-end scenarios (Policy Denial, Golden Path, Secret Rotation)
make down        # Tears down the Kind cluster
```

## Internal Components Demonstrated
1. **Kyverno Policies**: Enforces mandatory labels (e.g. `team`) on namespaces.
2. **Admission Webhook**: Mutating and validating webhooks built from scratch.
3. **Golden Path Provisioner**: A custom Kubernetes operator that provisions standard developer namespaces, RBAC, and Quotas from a single `GoldenPath` CRD.
4. **Secret Rotation Operator**: Automates generation and rotation of application secrets.

## Known Limitations
- The demo relies on `kind` (Kubernetes in Docker) for isolated execution.
- Images are built locally and loaded directly into the `kind` cluster (`make load-images`) rather than using a remote container registry.
