export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-FRX"

# Use gcr-ssh-agent (from gcr-4) so SSH key passphrases are stored in
# gnome-keyring and unlocked at login (Apple Keychain-style). The agent is a
# systemd user unit (gcr-ssh-agent.socket) enabled by install.sh.
if [[ -z "${SSH_AUTH_SOCK:-}" ]] && [[ -n "${XDG_RUNTIME_DIR:-}" ]] \
   && [[ -S "$XDG_RUNTIME_DIR/gcr/ssh" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gcr/ssh"
fi
