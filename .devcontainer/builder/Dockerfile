# Use Ubuntu 22 since most jobs in .github/workflows/ci-build.yaml run on ubuntu-22.04
# The dev environment should ideally match the CI pipeline as closely as feasible
# to minimize the "works on my machine" problem.
FROM mcr.microsoft.com/vscode/devcontainers/base:ubuntu-22.04

# TARGETARCH is automatically set by BuildKit to the architecture (e.g. "amd64" or "arm64")
# Docs: https://docs.docker.com/reference/dockerfile/#automatic-platform-args-in-the-global-scope
ARG TARGETARCH

# Use k3d since the CI pipeline uses k3s.
# We could use k3s directly, but k3d makes it easier to maange multiple clusters.
# k3d releases: https://github.com/k3d-io/k3d/releases
ARG K3D_VERSION=v5.8.3

# This is the minimum supported Kubernetes version in .github/workflows/ci-build.yaml
# Using the minimum version helps catch BC-breaking changes as early as possible.
# TODO: Dedupe like in https://github.com/argoproj/argo-workflows/pull/14176
ENV K8S_VERSION=v1.30.4

# Docs: https://k3d.io/stable/#install-specific-release
RUN wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | TAG=${K3D_VERSION} bash

# Docs: https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
RUN wget -O /usr/local/bin/kubectl "https://dl.k8s.io/release/${K8S_VERSION}/bin/linux/${TARGETARCH}/kubectl" && \
  chmod +x /usr/local/bin/kubectl

# Docs: https://docs.tilt.dev/install.html#manual-install
#RUN curl -fsSL https://github.com/tilt-dev/tilt/releases/download/${TILT_VERSION}/tilt.${TILT_VERSION}.linux.${TARGETARCH}.tar.gz | tar -xzv tilt && \
#  mv tilt /usr/local/bin/tilt