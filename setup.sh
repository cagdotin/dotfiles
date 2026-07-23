#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() {
  printf '\n==> %s\n' "$1"
}

run_if_exists() {
  local script="$1"
  if [ -x "$ROOT_DIR/$script" ]; then
    "$ROOT_DIR/$script"
  else
    echo "Skipping missing or non-executable script: $script"
  fi
}

step "Bootstrap system packages"
run_if_exists "scripts/bootstrap.sh"

step "Link mise"
run_if_exists "scripts/link-mise.sh"

step "Link Neovim / LazyVim"
run_if_exists "scripts/link-nvim.sh"

step "Link Starship"
run_if_exists "scripts/link-starship.sh"

step "Link Zed"
run_if_exists "scripts/link-zed.sh"

step "Link Herdr"
run_if_exists "scripts/link-herdr.sh"

step "Link Pi global skills"
run_if_exists "scripts/link-pi-skills.sh"

step "Link remaining dotfiles"
run_if_exists "scripts/link-configs.sh"

step "Install mise-managed tools"
run_if_exists "scripts/sync-mise.sh"

step "Sync Neovim / LazyVim"
run_if_exists "scripts/sync-nvim.sh"

step "Done"
echo "Dotfiles setup complete."
