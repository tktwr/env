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
  local files="\
    $MY_BIN/90.setup/*.sh \
    $SYS_CONFIG_HOME/lconfig/bin/*.sh \
    ./make.sh \
    "
  args=$(fzf_cmd_rg -w "$1\(\)" $files | awk -F ':' '{print $1,$2}')
  if [ -n "$args" ]; then
    eval "preview_rg.sh $args"
  fi
}

fzf_cmd() {
  cmd="$1"
  export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $(f_fzf_pw_opt)"
  echo $(eval "$cmd f_fzf_help" | \
    fzf_cmd_pre | \
    fzf --prompt "$cmd> " --preview 'fzf_cmd_preview {}' | \
    fzf_cmd_post)
}

export -f fzf_cmd_rg
export -f fzf_cmd_preview

#------------------------------------------------------
cmd=${1:-"cmd.sh"}
fzf_cmd "$cmd"
