#!/bin/bash

fzy_arg_rg() {
  topdir=$(git rev-parse --show-toplevel)
  cd $topdir
  rg --vimgrep --hidden "$*" | fzy | awk -F ':' '{print "'"$topdir/"'"$1}'
}

in_git=$(git rev-parse --is-inside-work-tree)

if [ "$in_git" != 'true' ]; then
  exit
fi

arg=$(prompt.sh 'search pattern' '' "$*")

if [ -n "$arg" ]; then
  fname=$(fzy_arg_rg "$arg")
  pathconv.sh unix "$fname"
fi

