#!/usr/bin/env bash
set -euo pipefail

CLUSTERS=("dev-cluster" "staging-cluster")

echo "Creating kubernetes clusters..."

for cluster in "${CLUSTERS[@]}"; do
  if k3d cluster list | grep -q "^${cluster}\b"; then
    echo "Cluster ${cluster} already exists. Skipping..."
  else
    echo "Creating cluster: ${cluster}"
    k3d cluster create "${cluster}" --agents 1
  fi
done

echo ""
echo "Available clusters:"
k3d cluster list

echo ""
echo "Available kubectl contexts:"
kubectl config get-contexts
