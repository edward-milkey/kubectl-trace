#!/bin/bash

set -eo pipefail

TAG_NAME="$(git describe --exact-match --tags)"
export TAG_NAME
echo "TAG_NAME=$TAG_NAME"

SHA_DARWIN_AMD64="$(sha256sum dist/kubectl-trace_"${TAG_NAME}"_darwin_amd64.tar.gz | awk '{print $1}')"
export SHA_DARWIN_AMD64
SHA_DARWIN_ARM64="$(sha256sum dist/kubectl-trace_"${TAG_NAME}"_darwin_arm64.tar.gz | awk '{print $1}')"
export SHA_DARWIN_ARM64
SHA_LINUX_ARM64="$(sha256sum dist/kubectl-trace_"${TAG_NAME}"_linux_arm64.tar.gz | awk '{print $1}')"
export SHA_LINUX_ARM64
SHA_LINUX_AMD64="$(sha256sum dist/kubectl-trace_"${TAG_NAME}"_linux_amd64.tar.gz | awk '{print $1}')"
export SHA_LINUX_AMD64

gomplate --file krew_plugin_manifest.yaml.tmpl --out krew_plugin_manifest.yaml

# release process:
# git tag <version>
# goreleaser release --clean -f .goreleaser-em.yml --verbose
# ./template_krew_plugin_manifest.sh
# commit and push krew manifest
