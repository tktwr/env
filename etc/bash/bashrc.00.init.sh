#!/bin/bash

#======================================================
# init
#======================================================

#umask 022
unalias -a

export HISTCONTROL=ignoreboth
export PAGER='less -FRX'
export EDITOR='vim'
#export GIT_PAGER='less'
#export GIT_EDITOR='vim'
export WWW_HOME="https://tktwr.github.io/memo/"

export MY_PROMPT_TYPE='minimal'

source $HOME/.my/hostname
source $HOME/.my/buildrc
source $HOME/.my/pythonrc
source $HOME/.my/pushdrc
source $HOME/.bashrc.env

