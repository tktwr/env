#!/bin/bash

#======================================================
# init
#======================================================

export MY_DEBUG=0

echo_err() {
  echo "$@" 1>&2
}

source_file() {
  local fname=$1
  if [ -f $fname ]; then
    source $fname
  else
    if [ $MY_DEBUG -eq 1 ]; then
      echo_err "no file: $fname"
    fi
  fi
}

#------------------------------------------------------

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

