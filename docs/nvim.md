# Neovim / LazyVim

This repo uses the official LazyVim starter layout.

## Paths

```text
~/code/dotfiles/config/nvim -> ~/.config/nvim
```

## Install/restore

```bash
cd ~/code/dotfiles
./scripts/bootstrap.sh
./scripts/link-nvim.sh
./scripts/sync-nvim.sh
```

## Notes

- `config/nvim` was created from `https://github.com/LazyVim/starter`.
- The starter repo's `.git` directory was removed so it can be tracked inside this dotfiles repo.
- Plugin data is not committed; it lives under Neovim's normal data/state/cache directories.
- `lazy-lock.json`, when present, should be committed for reproducible plugin versions.
