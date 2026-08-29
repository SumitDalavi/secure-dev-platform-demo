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
