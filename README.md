# omarchy-dotfiles

My personal dotfiles for [Omarchy](https://omarchy.org) (Arch Linux).

## Stack
- **Terminal:** [Ghostty](https://ghostty.org) (default on Omarchy; uses your login shell)
- **Shell:** Zsh (no framework) — set as login shell by `install.sh`
- **Prompt:** [Starship](https://starship.rs) — Pastel Powerline preset
- **Plugins:** `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **Version manager:** [mise](https://mise.jdx.dev)
- **Secrets:** [fnox](https://fnox.jdx.dev) (auto-loaded on `cd` into a project with `fnox.toml`)
- **Navigation:** zoxide + fzf (both shipped with Omarchy)
- **Editor:** Neovim

## Install

```sh
git clone git@github.com:micahvdk/omarchy-dotfiles.git ~/omarchy-dotfiles
cd ~/omarchy-dotfiles
./install.sh
exec zsh
```

The installer is idempotent and will:
- `pacman -S --needed` the required packages
- `yay -S --needed` AUR packages (fnox)
- Symlink configs into `$HOME` and `$XDG_CONFIG_HOME` (overwriting anything there)
- Create `~/.ssh/config.d/` for per-host overrides
- Copy `zsh/secret.zsh.example` to `zsh/secret.zsh` (gitignored) for private exports
- `chsh` your login shell to zsh

### Bootstrap GitHub SSH

After `install.sh`, authenticate with GitHub over SSH in one shot:

```sh
./bin/bootstrap-github-ssh
```

This generates `~/.ssh/id_ed25519` (if missing), adds it to ssh-agent, uploads
the public key to your GitHub account via `gh`, and verifies the connection.

## Layout

```
zsh/
  zshrc         # ~/.zshrc — sources env/aliases/functions/secret + inits tools
  env.zsh       # EDITOR, PAGER, etc.
  aliases.zsh
  functions.zsh
  secret.zsh    # gitignored; private exports
starship/
  starship.toml # ~/.config/starship.toml
mise/
  config.toml   # ~/.config/mise/config.toml — global tool versions
ssh/
  config        # ~/.ssh/config — includes ~/.ssh/config.d/*.config
bin/
  bootstrap-github-ssh  # one-shot: generate key + upload to GitHub via gh
install.sh
```

## Customising

- Global tool versions: edit `mise/config.toml` then `mise install`.
- Prompt: edit `starship/starship.toml` (see [presets](https://starship.rs/presets/)).
- Per-host SSH: drop files into `~/.ssh/config.d/`.
