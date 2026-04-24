# omarchy-dotfiles

My personal dotfiles for [Omarchy](https://omarchy.org) (Arch Linux).

## Stack
- **Shell:** Zsh (no framework)
- **Prompt:** [Starship](https://starship.rs) — Pastel Powerline preset
- **Plugins:** `zsh-autosuggestions`, `zsh-syntax-highlighting`
- **Version manager:** [mise](https://mise.jdx.dev)
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
- Symlink configs into `$HOME` and `$XDG_CONFIG_HOME` (overwriting anything there)
- Create `~/.ssh/config.d/` for per-host overrides
- Copy `zsh/secret.zsh.example` to `zsh/secret.zsh` (gitignored) for private exports
- `chsh` your login shell to zsh

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
install.sh
```

## Customising

- Global tool versions: edit `mise/config.toml` then `mise install`.
- Prompt: edit `starship/starship.toml` (see [presets](https://starship.rs/presets/)).
- Per-host SSH: drop files into `~/.ssh/config.d/`.
