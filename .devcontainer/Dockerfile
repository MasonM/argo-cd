# TODO: Upgrade to Ubuntu 24.04 when https://bugs.launchpad.net/ubuntu/+source/curl/+bug/2073448 is addressed
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

# k3d version: https://github.com/k3d-io/k3d/releases
ARG K3D_VERSION=v5.8.3

# TARGETARCH is automatically set by BuildKit to the architecture (e.g. "amd64" or "arm64")
# Docs: https://docs.docker.com/reference/dockerfile/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

# install protocol buffer tools
#RUN apt-get update && apt-get install -y protobuf-compiler clang-format

# install k3d
RUN wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=${K3D_VERSION} bash

# install kubectl for the minimum supported Kubernetes version in .github/workflows/ci-build.yaml
RUN wget -O /usr/local/bin/kubectl "https://dl.k8s.io/release/v1.30.4/bin/linux/${TARGETARCH}/kubectl" && \
  chmod +x /usr/local/bin/kubectl
