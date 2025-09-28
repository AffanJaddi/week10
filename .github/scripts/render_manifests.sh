#!/usr/bin/env bash
set -euo pipefail

MANIFEST_DIR="${1:-k8s/base}"
OUT_DIR="${2:-rendered}"
NAMESPACE="${NAMESPACE:-default}"
ACR_LOGIN_SERVER="${ACR_LOGIN_SERVER:?missing}"
IMAGE_TAG="${IMAGE_TAG:?missing}"

mkdir -p "$OUT_DIR"
for f in "$MANIFEST_DIR"/*deploy.yaml; do
  bn="$(basename "$f")"
  sed \
    -e "s|\${NAMESPACE}|$NAMESPACE|g" \
    -e "s|\${ACR_LOGIN_SERVER}|$ACR_LOGIN_SERVER|g" \
    -e "s|\${IMAGE_TAG}|$IMAGE_TAG|g" \
    "$f" > "$OUT_DIR/$bn"
done

echo "Rendered manifests to $OUT_DIR"
