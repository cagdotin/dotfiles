#!/usr/bin/env bash
set -euo pipefail

if ! command -v agent-browser >/dev/null 2>&1; then
  echo "agent-browser is not installed. Run ./scripts/bootstrap.sh first."
  exit 1
fi

agent-browser install

if ! command -v lightpanda >/dev/null 2>&1; then
  if [ "$(uname -s)" = "Darwin" ] && [ "$(uname -m)" = "arm64" ]; then
    mkdir -p "$HOME/.local/bin"
    curl -L --fail --show-error \
      -o "$HOME/.local/bin/lightpanda" \
      "https://github.com/lightpanda-io/browser/releases/download/nightly/lightpanda-aarch64-macos"
    chmod a+x "$HOME/.local/bin/lightpanda"
    echo "Installed lightpanda -> $HOME/.local/bin/lightpanda"
  else
    echo "Skipping automatic lightpanda install for unsupported platform: $(uname -s) $(uname -m)"
  fi
else
  echo "lightpanda already installed: $(command -v lightpanda)"
fi
