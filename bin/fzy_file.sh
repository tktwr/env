#!/bin/bash

cd_git_root() {
  topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$topdir" ]; then
    cd $topdir
    topdir="$topdir/"
  fi
}

#------------------------------------------------------
fzy_find_post() {
  awk '{print $1}'
}

fzy_find() {
  depth=${1:-6}
  cmd="find-txt.sh -maxdepth $depth"

  p=$(eval $cmd | fzy | fzy_find_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
cd_git_root

fzy_find "$@"
