#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/config/ghostty/config.ghostty"
TARGET="$HOME/Library/Application Support/com.mitchellh.ghostty/config.ghostty"
BACKUP_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -f "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected Ghostty config at config/ghostty/config.ghostty inside the dotfiles repo."
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR"
  mv "$TARGET" "$BACKUP_DIR/config.ghostty"
  echo "Backed up $TARGET -> $BACKUP_DIR/config.ghostty"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
