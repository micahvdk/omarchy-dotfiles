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
  ghostty \
  tmux \
  neovim \
  pkgfile \
  gnome-keyring \
  gcr-4 \
  libsecret

log "Installing AUR packages (yay)"
if ! command -v yay &>/dev/null; then
  die "yay is required for AUR packages (fnox). Install yay first."
fi
yay -S --needed --noconfirm fnox

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  log "Installing Oh My Zsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
else
  log "Oh My Zsh already installed; skipping clone"
fi

# pkgfile cache (powers the command-not-found zsh plugin)
if command -v pkgfile &>/dev/null; then
  if [[ ! -d /var/cache/pkgfile ]] || [[ -z "$(ls -A /var/cache/pkgfile 2>/dev/null)" ]]; then
    log "Updating pkgfile cache (one-time)"
    sudo pkgfile --update
  fi
fi

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
link "$DOTFILES/tmux/tmux.conf"         "$HOME/.config/tmux/tmux.conf"
link "$DOTFILES/hypr/overrides.conf"    "$HOME/.config/hypr/overrides.conf"
link "$DOTFILES/ssh/config"             "$HOME/.ssh/config"

mkdir -p "$HOME/.ssh/config.d"
chmod 700 "$HOME/.ssh" "$HOME/.ssh/config.d"

# Ensure Hyprland sources our overrides file (idempotent).
HYPR_MAIN="$HOME/.config/hypr/hyprland.conf"
HYPR_SRC_LINE="source = ~/.config/hypr/overrides.conf"
if [[ -f "$HYPR_MAIN" ]] && ! grep -qxF "$HYPR_SRC_LINE" "$HYPR_MAIN"; then
  log "Sourcing hypr/overrides.conf from $HYPR_MAIN"
  printf '\n# Personal overrides from omarchy-dotfiles\n%s\n' "$HYPR_SRC_LINE" >> "$HYPR_MAIN"
fi

if command -v hyprctl &>/dev/null && [[ -n "${HYPRLAND_INSTANCE_SIGNATURE:-}" ]]; then
  hyprctl reload >/dev/null 2>&1 || true
fi

# Configure PAM so gnome-keyring auto-unlocks at login with the user's
# password (Apple Keychain-style for SSH keys). Idempotent: only appends if
# the lines aren't already present. We patch every PAM service that's
# plausibly the login entry point on this system.
configure_keyring_pam() {
  local service="$1"
  local file="/etc/pam.d/$service"
  [[ -f "$file" ]] || return 0
  local auth_line="auth     optional  pam_gnome_keyring.so"
  local sess_line="session  optional  pam_gnome_keyring.so auto_start"
  if ! sudo grep -qF 'pam_gnome_keyring.so' "$file"; then
    log "Adding pam_gnome_keyring to $file"
    printf '\n# Added by omarchy-dotfiles for SSH key auto-unlock\n%s\n%s\n' \
      "$auth_line" "$sess_line" | sudo tee -a "$file" >/dev/null
  fi
}

for svc in login greetd sddm gdm-password lightdm ly; do
  configure_keyring_pam "$svc"
done

# Enable the gcr-ssh-agent user socket so SSH_AUTH_SOCK is available at login.
if command -v systemctl &>/dev/null; then
  log "Enabling gcr-ssh-agent.socket (user)"
  systemctl --user enable --now gcr-ssh-agent.socket >/dev/null 2>&1 || \
    warn "Failed to enable gcr-ssh-agent.socket (run manually: systemctl --user enable --now gcr-ssh-agent.socket)"
fi

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
