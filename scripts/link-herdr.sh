#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/config/herdr/config.toml"
TARGET="$HOME/.config/herdr/config.toml"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -f "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected Herdr config at config/herdr/config.toml inside the dotfiles repo."
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR/.config/herdr"
  mv "$TARGET" "$BACKUP_DIR/.config/herdr/config.toml"
  echo "Backed up $TARGET -> $BACKUP_DIR/.config/herdr/config.toml"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
