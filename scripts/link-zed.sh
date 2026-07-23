#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/config/zed/settings.json"
TARGET="$HOME/.config/zed/settings.json"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -f "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected Zed settings at config/zed/settings.json inside the dotfiles repo."
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR/.config/zed"
  mv "$TARGET" "$BACKUP_DIR/.config/zed/settings.json"
  echo "Backed up $TARGET -> $BACKUP_DIR/.config/zed/settings.json"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
