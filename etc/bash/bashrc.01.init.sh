#!/bin/bash

#======================================================
# init
#======================================================
#umask 022
unalias -a

source_file $HOME/.my/*.sh

#------------------------------------------------------
# less options:
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init

export COLUMNS
export HISTCONTROL=ignoreboth
export PAGER='less -FRX'
export EDITOR='vim'
export GIT_PAGER='less -EFRSX'
export GIT_EDITOR='vim'
export WWW_HOME="https://tktwr.github.io/memo/"

shopt -s no_empty_cmd_completion

f_fzf_help() {
  declare -F | grep '\-f ' | awk '{print $3}' | grep '\<f_' | grep -v 'f_fzf_help'
}

f_fzf_default() {
  f_fzf_help
}

f_fzf_main() {
  func_name=${1:-"f_fzf_default"}
  shift
  eval "$func_name $@"
}

export -f f_fzf_help
export -f f_fzf_default
export -f f_fzf_main
