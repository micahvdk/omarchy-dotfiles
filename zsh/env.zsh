export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-FRX"

# fnox: tell the age provider where the private key lives so secrets stored
# in ~/.config/fnox/config.toml decrypt automatically in every shell. This
# must be exported before `fnox activate zsh` runs in zshrc.
if [[ -f "$HOME/.config/age/keys.txt" ]]; then
  export FNOX_AGE_KEY_FILE="$HOME/.config/age/keys.txt"
fi

# Use gcr-ssh-agent (from gcr-4) so SSH key passphrases are stored in
# gnome-keyring and unlocked at login (Apple Keychain-style). The agent is a
# systemd user unit (gcr-ssh-agent.socket) enabled by install.sh.
if [[ -z "${SSH_AUTH_SOCK:-}" ]] && [[ -n "${XDG_RUNTIME_DIR:-}" ]] \
   && [[ -S "$XDG_RUNTIME_DIR/gcr/ssh" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi
