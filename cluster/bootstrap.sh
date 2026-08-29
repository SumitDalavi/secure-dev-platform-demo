#!/bin/bash
set -e

echo "Installing cert-manager..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.0/cert-manager.yaml
kubectl wait --for=condition=Available deployment --all -n cert-manager --timeout=120s

echo "Installing Vault in dev mode..."
helm repo add hashicorp https://helm.releases.hashicorp.com || true
helm install vault hashicorp/vault --set server.dev.enabled=true -n vault --create-namespace

echo "Installing Kyverno..."
helm repo add kyverno https://kyverno.github.io/kyverno/ || true
helm install kyverno kyverno/kyverno --version 3.0.0 -n kyverno --create-namespace

echo "Loading locally built images..."
kind load docker-image golden-path-provisioner:latest --name platform-demo || echo "Skipping local image load (golden-path-provisioner)"
kind load docker-image admission-webhook:latest --name platform-demo || echo "Skipping local image load (admission-webhook)"
kind load docker-image secret-rotation-operator:latest --name platform-demo || echo "Skipping local image load (secret-rotation-operator)"

echo "Bootstrap complete."
