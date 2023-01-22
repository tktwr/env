#!/bin/bash

#------------------------------------------------------
fzf_rg_post() {
  awk -F ':' '{print $1}'
}

fzf_rg() {
  cmd="rg --vimgrep $*"

  p=$(eval $cmd | fzf | fzf_rg_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
arg=$(prompt.sh 'search pattern' '' "$*")

if [ -n "$arg" ]; then
  fzf_rg "$arg"
fi

