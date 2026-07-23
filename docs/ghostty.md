# Ghostty

Ghostty is installed with Homebrew as a cask:

```ruby
cask "ghostty"
```

The user config is tracked at:

```text
config/ghostty/config.ghostty
```

and symlinked to:

```text
~/Library/Application Support/com.mitchellh.ghostty/config.ghostty
```

Only the user config is tracked. Generated/automatic files such as `auto/theme.ghostty` are not tracked.

## Homebrew status

Ghostty is managed by Homebrew Cask on this machine.
