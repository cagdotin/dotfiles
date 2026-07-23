#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/config/nvim"
TARGET="$HOME/.config/nvim"
BACKUP_DIR="$HOME/.config-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected LazyVim config at config/nvim inside the dotfiles repo."
  exit 1
fi

mkdir -p "$HOME/.config"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR/.config"
  mv "$TARGET" "$BACKUP_DIR/.config/nvim"
  echo "Backed up $TARGET -> $BACKUP_DIR/.config/nvim"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
