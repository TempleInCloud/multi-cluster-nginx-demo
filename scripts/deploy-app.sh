#!/usr/bin/env bash
set -euo pipefail

CLUSTERS=("k3d-dev-cluster" "k3d-staging-cluster")

for context in "${CLUSTERS[@]}"; do
  echo ""
  echo "Deploying app to ${context}..."

  kubectl apply -f manifests/app/namespace.yaml --context "${context}"
  kubectl apply -f manifests/app/deployment.yaml --context "${context}"
  kubectl apply -f manifests/app/service.yaml --context "${context}"

  echo "Waiting for deployment rollout in ${context}..."
  kubectl rollout status deployment/demo-nginx -n platform-demo --context "${context}"
done

echo ""
echo "Application deployed successfully to all clusters."
