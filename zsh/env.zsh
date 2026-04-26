export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-FRX"

# Use gnome-keyring's ssh-agent so SSH key passphrases unlock automatically
# at login (Apple Keychain-style). The daemon is started by Hyprland; PAM
# unlocks the keyring with the login password. See install.sh for setup.
if [[ -z "${SSH_AUTH_SOCK:-}" ]] && [[ -n "${XDG_RUNTIME_DIR:-}" ]] \
   && [[ -S "$XDG_RUNTIME_DIR/keyring/ssh" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
fi
