#!/bin/bash

export MY_ETC="$HOME/WinHome/MyConfig/tktwr.github/env/etc"
export USER_PYTHON_HOME="$HOME/WinHome/AppData/Local/Programs/Python/Python38"

export PATH="$USER_PYTHON_HOME:$PATH"
export PATH="$USER_PYTHON_HOME/Scripts:$PATH"

export PS1="[\w]$ "

alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'
alias ls='ls -F --color=auto'
alias vi='vim'
alias cd.etc='cd $MY_ETC'
