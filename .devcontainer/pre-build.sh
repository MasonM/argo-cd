#!/usr/bin/env bash
set -eux

# create cluster
k3d cluster get k3s-default || k3d cluster create k3s-default --image "rancher/k3s:${K8S_VERSION}-k3s1" --wait --registry-create k3s-registry
k3d kubeconfig merge --kubeconfig-merge-default
kubectl cluster-info

# Install standard tools
make install-tools-local

# Install Goreman: https://github.com/mattn/goreman#installation
go install github.com/mattn/goreman@latest