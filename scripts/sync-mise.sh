#!/usr/bin/env bash
set -euo pipefail

if ! command -v mise >/dev/null 2>&1; then
  echo "mise is not installed. Run ./scripts/bootstrap.sh first."
  exit 1
fi

mise install --yes
