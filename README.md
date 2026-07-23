# dotfiles

Personal macOS development environment and application configuration.

## Layout

```text
Brewfile              Homebrew formulae/casks
config/               XDG configs linked into ~/.config
agents/               Global agent assets, such as Pi skills
shell/                Shell config files
scripts/              Focused bootstrap/link/sync scripts
macos/                macOS defaults scripts
docs/                 Notes about manual setup
```

## Restore on a new machine

```bash
git clone git@github.com:YOUR_USERNAME/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./setup.sh
```

## Tracked configs

Currently safe-tracked from this machine:

- `~/.config/nvim` — LazyVim starter config
- `~/.config/mise` — mise global tool versions/config
- `~/.config/starship.toml`
- `~/.config/zed/settings.json`
- `~/.config/herdr/config.toml`
- `~/.pi/agent/skills` — global Pi skills

## Not tracked directly

These may contain credentials, sessions, logs, caches, or machine-local data:

- `~/.config/gcloud`
- `~/.config/raycast`
- `~/.config/herdr` except `config.toml`
- `~/.config/configstore`

Document their setup manually instead of committing their full directories.

## Pi skills

Global Pi skills live at:

```text
~/dev/dotfiles/agents/skills
```

and are symlinked to:

```text
~/.pi/agent/skills
```

Skills are available globally to Pi and are loaded on-demand based on their `description` or explicitly with `/skill:name`.

The `agent-browser` CLI is installed as a global npm package from `Brewfile`; `setup.sh` also runs `scripts/sync-agent-browser.sh` to install its browser runtime.

## mise

mise is installed through `Brewfile`. The mise config lives at:

```text
~/dev/dotfiles/config/mise
```

and is symlinked to:

```text
~/.config/mise
```

To relink only mise:

```bash
./scripts/link-mise.sh
```

To install mise-managed tools from `config/mise/config.toml`:

```bash
./scripts/sync-mise.sh
```

## Neovim / LazyVim

Neovim is installed through `Brewfile`. The LazyVim config lives at:

```text
~/dev/dotfiles/config/nvim
```

and is symlinked to:

```text
~/.config/nvim
```

To relink only Neovim:

```bash
./scripts/link-nvim.sh
```

To sync LazyVim plugins after setup:

```bash
./scripts/sync-nvim.sh
```
