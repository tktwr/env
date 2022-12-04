#!/bin/bash

#------------------------------------------------------
fzy_rg_post() {
  awk -F ':' '{print $1}'
}

fzy_rg() {
  cmd="rg --vimgrep $*"

  p=$(eval $cmd | fzy | fzy_rg_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
arg=$(prompt.sh 'search pattern' '' "$*")

if [ -n "$arg" ]; then
  fzy_rg "$arg"
fi

