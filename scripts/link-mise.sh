#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/config/mise"
TARGET="$HOME/.config/mise"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected mise config at config/mise inside the dotfiles repo."
  exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR/.config"
  mv "$TARGET" "$BACKUP_DIR/.config/mise"
  echo "Backed up $TARGET -> $BACKUP_DIR/.config/mise"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
