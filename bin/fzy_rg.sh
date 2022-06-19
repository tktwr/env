#!/bin/bash

cd_git_root() {
  topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$topdir" ]; then
    cd $topdir
    topdir="$topdir/"
  fi
}

#------------------------------------------------------
rg_post() {
  awk -F ':' '{print $1}'
}

fzy_rg() {
  cmd="rg --vimgrep $*"

  p=$(eval $cmd | fzy | rg_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
cd_git_root

arg=$(prompt.sh 'search pattern' '' "$*")

if [ -n "$arg" ]; then
  fzy_rg "$arg"
fi

