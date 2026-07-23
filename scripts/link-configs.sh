#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

backup_path() {
  local target="$1"
  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_DIR$(dirname "${target#$HOME}")"
    mv "$target" "$BACKUP_DIR/${target#$HOME/}"
    echo "Backed up $target -> $BACKUP_DIR/${target#$HOME/}"
  fi
}

link_path() {
  local source="$1"
  local target="$2"
  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "Already linked $target -> $source"
    return
  fi

  backup_path "$target"
  ln -s "$source" "$target"
  echo "Linked $target -> $source"
}

# Add generic config links here if they do not need a dedicated script.

echo "Done. Backups, if any, are in: $BACKUP_DIR"
