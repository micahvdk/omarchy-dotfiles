fetch-and-prune() {
  git fetch --all >/dev/null
  git remote prune origin
}

git-clean() {
  fetch-and-prune
  git branch -vv | awk '/origin\/.*: gone]/ {print $1}' | xargs -r git branch -D
}

cleanup-local-branches() {
  git fetch --all
  git remote prune origin
  git branch -vv | awk '/origin\/.*: gone]/ {print $1}' | xargs -r git branch -D
}
