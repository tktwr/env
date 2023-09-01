#!/bin/bash

fzf_cmd_pre() {
  grep -v '\-\-\-'
}

fzf_cmd_post() {
  awk '{print $1}'
}

fzf_cmd() {
  cmd="$1"
  echo $(eval "$cmd f_fzf_help" | fzf_cmd_pre | fzf --prompt "$cmd> " | fzf_cmd_post)
}

#------------------------------------------------------
cmd=${1:-"mymake.sh"}
fzf_cmd "$cmd"
