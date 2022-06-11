#!/bin/bash

fzy_arg_rg() {
  topdir=$(git rev-parse --show-toplevel)
  cd $topdir
  rg --vimgrep --hidden $1 | fzy | awk -F ':' '{print "'"$topdir/"'"$1}'
}

in_git=$(git rev-parse --is-inside-work-tree)

if [ "$in_git" = 'true' ]; then
  fname=$(fzy_arg_rg $1)
  pathconv.sh unix "$fname"
fi

