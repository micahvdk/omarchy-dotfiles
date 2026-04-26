# Spaceship prompt configuration.
# Sourced from zshrc *before* oh-my-zsh loads the theme so SPACESHIP_*
# variables take effect. See https://spaceship-prompt.sh/config/main/
#
# Goal: a powerlevel10k-flavoured layout — two-line prompt, bold cwd,
# rich git status, language/runtime version on the left, and time + exit
# code on the right via RPROMPT.

# ---------- left prompt ----------
SPACESHIP_PROMPT_ORDER=(
  user          # username (only when remote / root)
  host          # hostname (only over SSH)
  dir           # current directory
  git           # git branch + status
  package       # package version
  node          # Node.js
  ruby          # Ruby
  golang        # Go
  rust          # Rust
  python        # Python
  docker        # Docker context
  kubectl       # kubectl context
  aws           # AWS profile
  venv          # Python venv
  exec_time     # last command duration
  line_sep      # newline → two-line prompt (p10k-style)
  jobs          # background jobs
  char          # prompt character
)

# ---------- right prompt (p10k vibe) ----------
SPACESHIP_RPROMPT_ORDER=(
  exit_code
  time
)

# ---------- general ----------
SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_PROMPT_SEPARATE_LINE=true
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW=false
SPACESHIP_PROMPT_PREFIXES_SHOW=true
SPACESHIP_PROMPT_SUFFIXES_SHOW=true

# Lambda-style char that turns red on non-zero exit, like p10k.
SPACESHIP_CHAR_SYMBOL="❯ "
SPACESHIP_CHAR_SYMBOL_ROOT="# "
SPACESHIP_CHAR_SUFFIX=""
SPACESHIP_CHAR_COLOR_SUCCESS="green"
SPACESHIP_CHAR_COLOR_FAILURE="red"
SPACESHIP_CHAR_COLOR_SECONDARY="yellow"

# ---------- segments ----------
SPACESHIP_TIME_SHOW=true
SPACESHIP_TIME_PREFIX=""
SPACESHIP_TIME_SUFFIX=""
SPACESHIP_TIME_FORMAT="%D{%H:%M:%S}"
SPACESHIP_TIME_COLOR="244"

SPACESHIP_USER_SHOW="needed"
SPACESHIP_USER_COLOR="yellow"
SPACESHIP_HOST_SHOW="needed"
SPACESHIP_HOST_COLOR="blue"

SPACESHIP_DIR_PREFIX=" "
SPACESHIP_DIR_TRUNC=3
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_COLOR="cyan"
SPACESHIP_DIR_LOCK_SYMBOL=" "

SPACESHIP_GIT_PREFIX="on "
SPACESHIP_GIT_SYMBOL=" "
SPACESHIP_GIT_BRANCH_PREFIX=" "
SPACESHIP_GIT_BRANCH_COLOR="magenta"
SPACESHIP_GIT_STATUS_PREFIX=" ["
SPACESHIP_GIT_STATUS_SUFFIX="]"
SPACESHIP_GIT_STATUS_COLOR="red"
SPACESHIP_GIT_STATUS_UNTRACKED="?"
SPACESHIP_GIT_STATUS_ADDED="+"
SPACESHIP_GIT_STATUS_MODIFIED="!"
SPACESHIP_GIT_STATUS_RENAMED="»"
SPACESHIP_GIT_STATUS_DELETED="✘"
SPACESHIP_GIT_STATUS_STASHED="$"
SPACESHIP_GIT_STATUS_UNMERGED="="
SPACESHIP_GIT_STATUS_AHEAD="⇡"
SPACESHIP_GIT_STATUS_BEHIND="⇣"
SPACESHIP_GIT_STATUS_DIVERGED="⇕"

SPACESHIP_NODE_PREFIX="via "
SPACESHIP_NODE_SYMBOL=" "
SPACESHIP_GOLANG_SYMBOL=" "
SPACESHIP_RUST_SYMBOL=" "
SPACESHIP_PYTHON_SYMBOL=" "
SPACESHIP_RUBY_SYMBOL=" "
SPACESHIP_DOCKER_SYMBOL=" "
SPACESHIP_KUBECTL_SYMBOL="☸ "
SPACESHIP_AWS_SYMBOL=" "

SPACESHIP_EXEC_TIME_PREFIX="took "
SPACESHIP_EXEC_TIME_ELAPSED=5
SPACESHIP_EXEC_TIME_COLOR="yellow"

SPACESHIP_EXIT_CODE_SHOW=true
SPACESHIP_EXIT_CODE_PREFIX=""
SPACESHIP_EXIT_CODE_SUFFIX=" "
SPACESHIP_EXIT_CODE_SYMBOL="✘ "
SPACESHIP_EXIT_CODE_COLOR="red"

SPACESHIP_JOBS_SYMBOL="✦"
SPACESHIP_JOBS_COLOR="blue"
