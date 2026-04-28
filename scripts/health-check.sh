#!/usr/bin/env bash
set -euo pipefail

CLUSTERS=("k3d-dev-cluster" "k3d-staging-cluster")

echo "Running cluster health checks..."

for context in "${CLUSTERS[@]}"; do
  echo ""
  echo "Checking cluster: ${context}"

  if kubectl cluster-info --context "${context}" >/dev/null 2>&1; then
    echo "Cluster reachable"
  else
    echo "Cluster NOT reachable"
    continue
  fi

  echo "Nodes:"
  kubectl get nodes --context "${context}" --no-headers | awk '{print "- " $1 ": " $2}'

  if kubectl get nodes --context "${context}" --no-headers | grep -v "Ready" >/dev/null; then
    echo "❌ Some nodes are NOT Ready"
  else
    echo "✅ All nodes are Ready"
  fi

  echo ""
  echo "System pods (kube-system):"
  kubectl get pods -n kube-system --context "${context}" --no-headers | awk '{print "- " $1 ": "$3}'

  if kubectl get pods -n kube-system --context "${context}" --no-headers | grep -v "Running\|Completed" >/dev/null; then
    echo "❌ Some system pods are unhealthy"
  else
    echo "✅ All system pods are healthy"
  fi
done

echo ""
echo "Health check completed."
