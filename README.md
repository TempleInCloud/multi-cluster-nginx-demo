# Multi-Cluster Kubernetes GitOps Lab

## Overview

This project demonstrates a multi-cluster Kubernetes setup using GitOps principles.

It includes:
- A local multi-cluster environment using k3d
- Application deployment using Kubernetes manifests
- GitOps deployment with ArgoCD
- Observability using Prometheus and Grafana
- CI pipeline to validate Kubernetes manifests before deployment

The goal is to simulate how modern platform teams manage infrastructure and applications across environments.

## Architecture

The system consists of:

- Multiple Kubernetes clusters (dev and staging) created using k3d
- ArgoCD for GitOps-based deployment
- Prometheus for metrics collection
- Grafana for visualization
- GitHub Actions for CI validation

Developers push code to GitHub → CI validates → ArgoCD syncs → Kubernetes deploys.

## Tools Used

- Kubernetes (k3d)
- ArgoCD
- Prometheus
- Grafana
- GitHub Actions
- Docker
- kubectl
- Bash scripting

## What This Project Demonstrates

- Multi-cluster Kubernetes management
- GitOps workflow using ArgoCD
- CI validation of Kubernetes manifests
- Observability setup with Prometheus and Grafana
- Deployment automation and scaling
- Separation of environments (dev vs staging)

## Project Structure

manifests/     → Kubernetes YAML files  
scripts/       → Automation scripts (cluster creation, deployment, cleanup)  
.github/       → CI pipeline configuration

## How It Works

1. Clusters are created using k3d scripts
2. Application manifests are stored in GitHub
3. ArgoCD watches the repository
4. When changes are made, ArgoCD syncs them to the cluster
5. Prometheus collects metrics
6. Grafana visualizes application performance

## CI/CD Flow

- GitHub Actions runs on every push
- It validates Kubernetes YAML files
- If validation fails, deployment is blocked
- If validation passes, changes can be synced via ArgoCD

## Observability

Prometheus is used to collect metrics from the Kubernetes cluster.

Grafana is used to visualize:
- CPU usage
- Memory usage
- Pod metrics

Dashboards provide insight into application performance and cluster health.
