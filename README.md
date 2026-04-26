# omarchy-dotfiles

My personal dotfiles for [Omarchy](https://omarchy.org) (Arch Linux).

## Stack
- **Terminal:** [Ghostty](https://ghostty.org) (default on Omarchy; uses your login shell)
- **Shell:** Zsh + [Oh My Zsh](https://ohmyz.sh) — set as login shell by `install.sh`
- **Prompt:** [Spaceship](https://spaceship-prompt.sh) — installed as an OMZ custom theme by `install.sh`
- **OMZ plugins:** `git`, `kubectl`, `gh`, `docker`, `tmux`, `sudo`, `archlinux`, `command-not-found`, `colored-man-pages`, `history-substring-search`, `extract`
- **Extra zsh plugins:** `zsh-autosuggestions`, `zsh-syntax-highlighting` (loaded after OMZ)
- **Version manager:** [mise](https://mise.jdx.dev)
- **Secrets:** [fnox](https://fnox.jdx.dev) (auto-loaded on `cd` into a project with `fnox.toml`)
- **Multiplexer:** tmux (prefix `C-b`, vi copy-mode, mouse on, splits `_`/`-`)
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
- Configure `pam_gnome_keyring` so the keyring (and your SSH keys) auto-unlock at login
- `chsh` your login shell to zsh

### SSH key auto-unlock (Apple Keychain-style)

`gnome-keyring` (Secret Service) plus `gcr-4`'s `gcr-ssh-agent.socket` give
you a persistent SSH agent whose passphrases are stored in the keyring.
`zsh/env.zsh` points `SSH_AUTH_SOCK` at `$XDG_RUNTIME_DIR/gcr/ssh` and
`ssh/config` has `AddKeysToAgent yes`. The installer enables the user socket
and adds `pam_gnome_keyring` to login PAM services so the keyring unlocks
with your login password.

After install, open a new shell and run `ssh-add ~/.ssh/id_ed25519` once —
enter the passphrase and it's then remembered for future sessions. Manage
stored secrets with `seahorse` (install on demand: `sudo pacman -S seahorse`).

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
spaceship/
  spaceship.zsh # SPACESHIP_* config, sourced from zshrc before OMZ loads
mise/
  config.toml   # ~/.config/mise/config.toml — global tool versions
tmux/
  tmux.conf     # ~/.config/tmux/tmux.conf
hypr/
  overrides.conf  # ~/.config/hypr/overrides.conf (Caps Lock → Escape, etc.)
ssh/
  config        # ~/.ssh/config — includes ~/.ssh/config.d/*.config
bin/
  bootstrap-github-ssh  # one-shot: generate key + upload to GitHub via gh
install.sh
```

## Customising

- Global tool versions: edit `mise/config.toml` then `mise install`.
- Prompt: edit `spaceship/spaceship.zsh` (see [Spaceship config](https://spaceship-prompt.sh/config/main/)).
- Per-host SSH: drop files into `~/.ssh/config.d/`.
