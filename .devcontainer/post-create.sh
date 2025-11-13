#!/usr/bin/env bash
set -eux

# Install standard tools
make install-tools-local

# Grab the minimum supported Kubernetes version in .github/workflows/ci-build.yaml
# using similar logic to hack/update-supported-versions.sh
go install github.com/mikefarah/yq/v4@latest
K8S_VERSION=$(yq '[.jobs["test-e2e"].strategy.matrix.k3s[] | .version] | min' .github/workflows/ci-build.yaml)

# Install kubectl
ARCHITECTURE=$(dpkg --print-architecture)
sudo wget -O /usr/local/bin/kubectl "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${ARCHITECTURE}/kubectl"
sudo chmod +x /usr/local/bin/kubectl

# Create cluster
k3d cluster get k3s-default || k3d cluster create k3s-default --image "rancher/k3s:${K8S_VERSION}-k3s1" --wait --registry-create k3s-registry
k3d kubeconfig merge --kubeconfig-merge-default
kubectl cluster-info