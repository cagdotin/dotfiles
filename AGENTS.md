# AGENTS.md

Guidance for coding agents working in this dotfiles repository.

## Repository purpose

This repo manages personal macOS dotfiles and setup automation. The repo lives at:

```text
~/dev/dotfiles
```

It should be portable to other machines and safe to publish to GitHub.

## Structure

```text
Brewfile              Homebrew formulae/casks/cargo/npm packages
setup.sh              Top-level setup wrapper
config/               XDG config files symlinked into ~/.config
shell/                Shell config files, when added
scripts/              Small focused setup/link/sync scripts
macos/                macOS defaults scripts, when added
docs/                 Human notes for apps and setup
AGENTS.md             Instructions for agents
```

## Setup flow

Prefer keeping scripts small and app-specific. The top-level setup should orchestrate them:

```bash
./setup.sh
```

Current setup order:

1. `scripts/bootstrap.sh` — install Homebrew if needed and run `brew bundle`
2. `scripts/link-mise.sh` — symlink mise config
3. `scripts/link-nvim.sh` — symlink Neovim/LazyVim config
4. `scripts/link-starship.sh` — symlink Starship config
5. `scripts/link-zed.sh` — symlink Zed settings
6. `scripts/link-configs.sh` — symlink any remaining tracked configs into `~/.config`
7. `scripts/sync-mise.sh` — install tools declared in mise config
8. `scripts/sync-nvim.sh` — run LazyVim plugin sync

For mise only:

```bash
./scripts/link-mise.sh
./scripts/sync-mise.sh
```

For Neovim only:

```bash
./scripts/link-nvim.sh
./scripts/sync-nvim.sh
```

## Symlink policy

Tracked configs live inside this repo, e.g.:

```text
config/nvim -> ~/.config/nvim
config/mise -> ~/.config/mise
config/starship.toml -> ~/.config/starship.toml
```

When adding new configs:

1. Put safe source files under `config/<app>` or `config/<file>`.
2. Update `scripts/link-configs.sh` or add a focused `scripts/link-<app>.sh`.
3. Ensure existing target files are backed up before replacing them.
4. Keep symlink scripts idempotent when possible.

## mise

mise global configuration lives under:

```text
config/mise
```

It is symlinked to `~/.config/mise`. `Brewfile` should include `brew "mise"`. Tool versions should be declared in `config/mise/config.toml`, and `scripts/sync-mise.sh` should run `mise install --yes`.

Do not commit mise-installed runtime directories, caches, or downloaded tool archives.

## Neovim / LazyVim

Neovim uses the official LazyVim starter under:

```text
config/nvim
```

`config/nvim/.git` must not exist. The LazyVim starter is vendored as normal files inside this dotfiles repo.

Commit `config/nvim/lazy-lock.json` for reproducible plugin versions. Do not commit plugin installation directories from Neovim data/cache/state paths.

## Safety rules

Do not commit secrets, credentials, tokens, local sessions, sockets, logs, caches, or machine-specific generated state.

Known unsafe or local-only config directories:

```text
~/.config/gcloud
~/.config/raycast
~/.config/herdr
~/.config/configstore
```

If adding new app configs, inspect them first. Prefer tracking only explicit safe files rather than whole generated directories.

## Package management

Homebrew packages are managed by `Brewfile`.

After intentional package changes, update the Brewfile manually or with care. Do not blindly re-dump if it would reintroduce removed/unwanted packages.


## Agent behavior

- Read files before editing.
- Use precise edits rather than rewrites where possible.
- Keep scripts POSIX-ish Bash with `set -euo pipefail`.
- Make setup scripts safe to rerun.
- Verify changes with `git status`, relevant command checks, and symlink checks.
