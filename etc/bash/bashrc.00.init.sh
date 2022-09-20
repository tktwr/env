#!/bin/bash

#======================================================
# init
#======================================================
#umask 022
unalias -a

source_file $HOME/.my/*

#------------------------------------------------------
# MY_PROMPT_TYPE:
# 0: none   [f_set_prompt_none]
# 1: min    [f_set_prompt_minimal, gitgutter]
# 2: middle [f_set_prompt_git_fast]
# 3: max    [f_set_prompt_git, fugitive, coc]
# 4: full   [fern-git-status]
case $MY_OS_NAME in
  wsl|linux)
    export MY_PROMPT_TYPE=4
    ;;
  msys|gitbash)
    export MY_PROMPT_TYPE=2
    ;;
esac

#------------------------------------------------------
export LANG=C
export HISTCONTROL=ignoreboth
export PAGER='less -FRX'
export EDITOR='vim'
#export GIT_PAGER='less'
#export GIT_EDITOR='vim'
export WWW_HOME="https://tktwr.github.io/memo/"

shopt -s no_empty_cmd_completion

