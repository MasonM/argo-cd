#! /usr/bin/env bash
set -eux -o pipefail

PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")"/../..; pwd)
DEVCONTAINER_IMAGE=$(sed --quiet 's/^ *"image": "\([^"]*\)",/\1/p' ${PROJECT_ROOT}/.devcontainer/devcontainer.json)

if [[ "${DEVCONTAINER_PUSH:-false}" = "true" ]]; then
  # Export both image and cache to the registry using zstd, since that produces much smaller images than gzip.
  # Docs: https://docs.docker.com/build/exporters/image-registry/ and https://docs.docker.com/build/cache/backends/registry/
  DEVCONTAINER_EXPORTER_COMMON_FLAGS='type=registry,compression=zstd,force-compression=true,oci-mediatypes=true'
  DEVCONTAINER_FLAGS="--output ${DEVCONTAINER_EXPORTER_COMMON_FLAGS} \
    --cache-to ${DEVCONTAINER_EXPORTER_COMMON_FLAGS},ref=${DEVCONTAINER_IMAGE}:cache,mode=max"
else
  DEVCONTAINER_FLAGS='--output type=cacheonly'
fi

if ! command -v devcontainer &>/dev/null; then
	npm i -g @devcontainers/cli@0.80.1
fi

devcontainer build \
  --workspace-folder ${PROJECT_ROOT} \
  --config ${PROJECT_ROOT}/.devcontainer/builder/devcontainer.json \
  --platform ${TARGET_ARCH} \
  --image-name ${DEVCONTAINER_IMAGE} \
  --cache-from ${DEVCONTAINER_IMAGE}:cache \
  ${DEVCONTAINER_FLAGS}