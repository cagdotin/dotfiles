# Apps and tools

## Managed by Homebrew

See `../Brewfile`.

Neovim/LazyVim-related tools managed there:

- `neovim`
- `lazygit`
- `ripgrep`
- `fd`
- Nerd Fonts

Useful commands:

```bash
brew bundle --file Brewfile
```

The `Brewfile` is curated manually. Do not blindly regenerate it with `brew bundle dump --force`, because Homebrew only dumps packages it currently manages and may remove intentional entries for apps/tools that are installed another way or not installed on the current machine yet.

If you need to refresh it, dump to a temporary file and review the diff manually:

```bash
brew bundle dump --file /tmp/Brewfile.current --force
diff -u Brewfile /tmp/Brewfile.current
```

## Apps seen on this machine

- Raycast — running; config not committed directly
- Zed — app installed; only `settings.json` tracked
- Brave Browser
- Spotify
- Trezor Suite
- ProtonVPN
- Proton Pass

## Removed / intentionally not managed

- k9s
- MySQL
- Tabby
- Zellij

## Configs intentionally not committed

- Google Cloud SDK: `~/.config/gcloud` contains credentials/tokens
- Raycast: may contain extension state, tokens, conversations, cache-like data
- herdr: contains logs, sockets, and session files
- configstore: generated app state
