# Architecture — Secure Developer Platform
> Last updated: 2026-08-29 | Maturity: Full Prototype
> _End-to-end secure developer platform demonstrating scaffolding, admission control, policy enforcement, resource provisioning, and automated secret rotation._

## System Architecture

```mermaid
flowchart TD
    Dev(["Developer"])

    subgraph Local ["Local Machine"]
        CLI["golden-path-cli\n$ gpc new myservice\nScaffolds repo + CR manifest"]
    end

    subgraph K8s ["kind Cluster"]
        API["kube-apiserver"]

        subgraph Admission ["Admission Control"]
            Webhook["k8s-admission-webhook\nMutating: inject labels\nValidating: require team label"]
            Kyverno["k8s-policy-as-code\nKyverno: enforce DENY\nif app.kubernetes.io/team missing"]
        end

        subgraph Controllers ["Controllers / Operators"]
            GPP["k8s-golden-path-provisioner\nReconciles GoldenPath CR:\n- Creates Namespace\n- Applies RBAC\n- Sets ResourceQuota"]
            SRO["k8s-secret-rotation-operator\nWatches RotationPolicy CR:\n- Fetches secret from Vault\n- Creates/rotates K8s Secret\n- Exposes /metrics"]
        end

        subgraph Identity ["Workload Identity"]
            SPIRE["SPIRE Agent\nIssues SVIDs to workloads"]
            ESO["External Secrets Operator\nSyncs Vault secrets → K8s"]
        end

        NS["Namespace + RBAC + Quota\n(created by provisioner)"]
        Secret["K8s Secret\n(rotated by operator)"]
    end

    subgraph Infra ["Supporting Infrastructure"]
        Vault["Vault Dev Server\nSecret storage + PKI"]
        CertMgr["cert-manager\nWebhook TLS certificate"]
    end

    IDP["internal-developer-platform-poc\nPortal: shows provisioned services,\naudit log, secret rotation status"]

    Dev -->|"gpc new myservice"| CLI
    CLI -->|"kubectl apply CR"| API
    API --> Webhook
    Webhook -->|"mutate: add labels"| API
    API --> Kyverno
    Kyverno -->|"DENY: missing label"| Dev
    Dev -->|"fix label, re-apply"| API
    Kyverno -->|"ALLOW"| GPP
    GPP -->|"create"| NS
    GPP -->|"trigger"| SRO
    SRO <-->|"fetch/rotate"| Vault
    SRO -->|"write"| Secret
    ESO <-->|"sync"| Vault
    SPIRE -->|"issue SVID"| NS
    CertMgr -->|"TLS cert"| Webhook
    GPP -.->|"service registered"| IDP
    SRO -.->|"rotation event"| IDP
```

## Component Overview

| Component | Responsibility | Tech |
|---|---|---|
| `golden-path-cli` | CLI for scaffolding new services. | Go |
| `k8s-golden-path-provisioner` | Kubernetes controller for CRD reconciliation. | Go |
| `k8s-admission-webhook-from-scratch` | Mutating/validating webhook. | Go |
| `k8s-secret-rotation-operator` | Operator to rotate secrets via Vault. | Go |
| `k8s-policy-as-code` | Kyverno OPA policies. | YAML |
| `cloud-native-secrets-identity` | SPIFFE/SPIRE + ESO + Vault setup. | YAML/Go |
| `internal-developer-platform-poc` | IDP portal. | React/Node.js |
