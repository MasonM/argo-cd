#!/usr/bin/env bash
set -eux

# create cluster using the minimum tested Kubernetes version
k3d cluster get k3s-default || k3d cluster create --image "rancher/k3s:v1.30.4-k3s1" --wait
k3d kubeconfig merge --kubeconfig-merge-default
kubectl cluster-info

# Make sure go path is owned by vscode
#sudo chown vscode:vscode /home/vscode/go || true
#sudo chown vscode:vscode /home/vscode/go/src || true
#sudo chown vscode:vscode /home/vscode/go/src/github.com || true
