#!/bin/bash

#======================================================
# init
#======================================================

# MY_PROMPT_TYPE:
# 0: none   [f_set_prompt_none]
# 1: min    [f_set_prompt_minimal, gitgutter]
# 2: middle [f_set_prompt_git_fast]
# 3: max    [f_set_prompt_git, fugitive, coc]
# 4: full   [fern-git-status]
export MY_PROMPT_TYPE=2

#------------------------------------------------------
#umask 022
unalias -a

export HISTCONTROL=ignoreboth
export PAGER='less -FRX'
export EDITOR='vim'
#export GIT_PAGER='less'
#export GIT_EDITOR='vim'
export WWW_HOME="https://tktwr.github.io/memo/"

source $HOME/.my/hostname
source $HOME/.my/buildrc
source $HOME/.my/pythonrc
source $HOME/.my/pushdrc
source $HOME/.bashrc.env

