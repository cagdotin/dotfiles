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
brew bundle dump --file Brewfile --force
brew bundle --file Brewfile
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
