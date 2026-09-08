# mise

mise is used for language/tool runtime management.

## Paths

```text
~/code/dotfiles/config/mise -> ~/.config/mise
```

## Current tools

Declared in `config/mise/config.toml`.

## Install/restore

```bash
cd ~/code/dotfiles
./scripts/bootstrap.sh
./scripts/link-mise.sh
./scripts/sync-mise.sh
```

`bootstrap.sh` installs mise via Homebrew using the `Brewfile`. `sync-mise.sh` runs:

```bash
mise install --yes
```
