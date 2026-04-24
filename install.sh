#!/usr/bin/env bash
# Personal Omarchy (Arch Linux) dotfiles bootstrap.
# Idempotent. Overwrites existing target files with symlinks (no backup).

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES

log() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m!!>\033[0m %s\n' "$*" >&2; }
die()  { printf '\033[1;31mxxx\033[0m %s\n' "$*" >&2; exit 1; }

[[ -f /etc/arch-release ]] || die "This installer targets Arch Linux / Omarchy."

log "Installing packages (pacman)"
sudo pacman -S --needed --noconfirm \
  zsh \
  zsh-autosuggestions \
  zsh-syntax-highlighting \
  zsh-completions \
  starship \
  mise \
  zoxide \
  fzf \
  git \
  github-cli \
  openssh \
  neovim

log "Installing AUR packages (yay)"
if ! command -v yay &>/dev/null; then
  die "yay is required for AUR packages (fnox). Install yay first."
fi
yay -S --needed --noconfirm fnox

link() {
  local src="$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  rm -rf "$dst"
  ln -s "$src" "$dst"
  log "linked $dst -> $src"
}

log "Linking config"
link "$DOTFILES/zsh/zshrc"              "$HOME/.zshrc"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
link "$DOTFILES/mise/config.toml"       "$HOME/.config/mise/config.toml"
link "$DOTFILES/ssh/config"             "$HOME/.ssh/config"

mkdir -p "$HOME/.ssh/config.d"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/config.d"

if [[ ! -f "$DOTFILES/zsh/secret.zsh" ]]; then
  cp "$DOTFILES/zsh/secret.zsh.example" "$DOTFILES/zsh/secret.zsh"
  log "created zsh/secret.zsh from example"
fi

ZSH_BIN="$(command -v zsh)"
if [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
  log "Changing login shell to $ZSH_BIN"
  sudo chsh -s "$ZSH_BIN" "$USER"
fi

log "Done. Open a new terminal (or run 'exec zsh') to pick up changes."
log "To authenticate with GitHub via SSH, run: $DOTFILES/bin/bootstrap-github-ssh"
