#!/bin/bash

fzf_make_pre() {
  grep -v '\-\-\-'
}

fzf_make_post() {
  awk '{print $1}'
}

fzf_make() {
  cmd="mymake.sh help"
  echo $(eval $cmd | fzf_make_pre | fzf --prompt 'make> ' | fzf_make_post)
}

#------------------------------------------------------
fzf_make "$@"

