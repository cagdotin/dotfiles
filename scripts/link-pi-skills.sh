#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_SOURCE="$DOTFILES_DIR/agents/skills"
SKILLS_TARGET="$HOME/.pi/agent/skills"
EXTENSIONS_SOURCE="$DOTFILES_DIR/agents/extensions"
EXTENSIONS_TARGET="$HOME/.pi/agent/extensions"
SETTINGS_SOURCE="$DOTFILES_DIR/agents/settings.json"
SETTINGS_TARGET="$HOME/.pi/agent/settings.json"
BACKUP_DIR="$HOME/.pi-backup-$(date +%Y%m%d-%H%M%S)"

link_path() {
  local source="$1"
  local target="$2"
  local backup_name="$3"

  mkdir -p "$(dirname "$target")"

  if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
    echo "Already linked $target -> $source"
    return 0
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    mkdir -p "$BACKUP_DIR/.pi/agent"
    mv "$target" "$BACKUP_DIR/.pi/agent/$backup_name"
    echo "Backed up $target -> $BACKUP_DIR/.pi/agent/$backup_name"
  fi

  ln -s "$source" "$target"
  echo "Linked $target -> $source"
}

if [ ! -d "$SKILLS_SOURCE" ]; then
  echo "Missing $SKILLS_SOURCE"
  echo "Expected Pi global skills at agents/skills inside the dotfiles repo."
  exit 1
fi

if [ ! -d "$EXTENSIONS_SOURCE" ]; then
  echo "Missing $EXTENSIONS_SOURCE"
  echo "Expected Pi global extensions at agents/extensions inside the dotfiles repo."
  exit 1
fi

if [ ! -f "$SETTINGS_SOURCE" ]; then
  echo "Missing $SETTINGS_SOURCE"
  echo "Expected Pi settings at agents/settings.json inside the dotfiles repo."
  exit 1
fi

link_path "$SKILLS_SOURCE" "$SKILLS_TARGET" "skills"

for extension_source in "$EXTENSIONS_SOURCE"/*; do
  if [ ! -e "$extension_source" ] && [ ! -L "$extension_source" ]; then
    continue
  fi

  extension_name="$(basename "$extension_source")"
  link_path "$extension_source" "$EXTENSIONS_TARGET/$extension_name" "extensions-$extension_name"
done

link_path "$SETTINGS_SOURCE" "$SETTINGS_TARGET" "settings.json"
