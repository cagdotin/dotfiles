#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$DOTFILES_DIR/agents/skills"
TARGET="$HOME/.pi/agent/skills"
BACKUP_DIR="$HOME/.pi-backup-$(date +%Y%m%d-%H%M%S)"

if [ ! -d "$SOURCE" ]; then
  echo "Missing $SOURCE"
  echo "Expected Pi global skills at agents/skills inside the dotfiles repo."
  exit 1
fi

mkdir -p "$(dirname "$TARGET")"

if [ -L "$TARGET" ] && [ "$(readlink "$TARGET")" = "$SOURCE" ]; then
  echo "Already linked $TARGET -> $SOURCE"
  exit 0
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  mkdir -p "$BACKUP_DIR/.pi/agent"
  mv "$TARGET" "$BACKUP_DIR/.pi/agent/skills"
  echo "Backed up $TARGET -> $BACKUP_DIR/.pi/agent/skills"
fi

ln -s "$SOURCE" "$TARGET"
echo "Linked $TARGET -> $SOURCE"
