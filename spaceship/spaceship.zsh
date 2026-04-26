# Spaceship prompt configuration.
# Sourced from zshrc *before* oh-my-zsh loads the theme so SPACESHIP_*
# variables take effect. See https://spaceship-prompt.sh/config/main/

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps
  user          # Username
  dir           # Current directory
  host          # Hostname (only over SSH)
  git           # Git branch and status
  package       # Package version
  node          # Node.js version
  ruby          # Ruby version
  golang        # Go version
  rust          # Rust version
  docker        # Docker context
  kubectl       # Kubectl context
  aws           # AWS profile
  venv          # Python virtualenv
  exec_time     # Execution time of last command
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code of last command
  char          # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_CHAR_SUFFIX=""

SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_FORMAT="%D{%H:%M}"

SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_REPO=false

SPACESHIP_GIT_BRANCH_PREFIX=" "
SPACESHIP_EXEC_TIME_ELAPSED=5
