#!/bin/bash

git-cd-root() {
  topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$topdir" ]; then
    cd $topdir
  fi
}

#------------------------------------------------------
fzf_find_post() {
  awk '{print $1}'
}

fzf_find() {
  depth=${1:-6}
  cmd="fdfind --type d --strip-cwd-prefix --max-depth $depth"

  p=$(eval $cmd | fzf | fzf_find_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
case "$1" in
  --git-root)
    git-cd-root
    shift
    ;;
esac

fzf_find "$@"
