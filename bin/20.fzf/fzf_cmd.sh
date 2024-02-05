#!/bin/bash

fzf_cmd_pre() {
  grep -v '\-\-\-'
}

fzf_cmd_post() {
  awk '{print $1}'
}

fzf_cmd_rg () {
  rg --with-filename --column --line-number --no-heading --smart-case $*
}

fzf_cmd_preview() {
  local setup_files="\
    $MY_BIN/90.setup/setup*.sh \
    $SYS_CONFIG_HOME/lconfig/bin/setup*.sh \
    "
  args=$(fzf_cmd_rg -w "$1" $setup_files | awk -F ':' '{print $1,$2}')
  if [ -n "$args" ]; then
    eval "preview_rg.sh $args"
  fi
}

fzf_cmd() {
  cmd="$1"
  echo $(eval "$cmd f_fzf_help" | fzf_cmd_pre | fzf --prompt "$cmd> " --preview 'fzf_cmd_preview {}' --preview-window "$(f_fzf_pw_opt)" | fzf_cmd_post)
}

export -f fzf_cmd_rg
export -f fzf_cmd_preview

#------------------------------------------------------
cmd=${1:-"mymake.sh"}
fzf_cmd "$cmd"
#fzf_cmd_preview $1
