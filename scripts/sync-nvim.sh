#!/usr/bin/env bash
set -euo pipefail

if ! command -v nvim >/dev/null 2>&1; then
  echo "nvim is not installed. Run ./scripts/bootstrap.sh first."
  exit 1
fi

nvim --headless '+Lazy! sync' +qa
