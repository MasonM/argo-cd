#!/usr/bin/env bash
set -eux

# create cluster
k3d cluster get k3s-default || k3d cluster create --image "rancher/k3s:${K8S_VERSION}-k3s1" --wait
k3d kubeconfig merge --kubeconfig-merge-default
kubectl cluster-info

# Install Goreman: https://github.com/mattn/goreman#installation
go install github.com/mattn/goreman@latest
make install-tools-local