#!/bin/bash

#------------------------------------------------------
# env
#------------------------------------------------------
export MY_HOME="/c/Users/$USERNAME"
export MY_ENV="$MY_HOME/MyConfig/tktwr.github/env"
export MY_ETC="$MY_ENV/etc"
export MY_BIN="$MY_ENV/bin"
export USER_PYTHON_HOME="$MY_HOME/AppData/Local/Programs/Python/Python38"

#------------------------------------------------------
# path
#------------------------------------------------------
if [ -z "$SYS_PATH" ]; then
  export SYS_PATH=$PATH
fi
export PATH="$SYS_PATH"

export PATH="$USER_PYTHON_HOME:$PATH"
export PATH="$USER_PYTHON_HOME/Scripts:$PATH"
export PATH="$MY_BIN:$PATH"

#------------------------------------------------------
# prompt
#------------------------------------------------------
export PS1="[\w]$ "

#------------------------------------------------------
# alias
#------------------------------------------------------
# directory stack
alias .='pushd'
alias ..='pushd +2'
alias ...='pushd +3'
alias ,='popd'
alias ,,='popd +1'
alias ,,,='popd +2'
alias ?='dirs -v'
alias .c='dirs -c'
alias .i='dirs -c; cd'

alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'
alias ls='ls -F --color=auto'
alias vi='vim'

alias cd.etc='cd $MY_ETC'
alias cd.bin='cd $MY_BIN'

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

