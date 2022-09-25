#!/bin/bash

#======================================================
# minimal bashrc
#======================================================
f_env() {
  export LANG=C
  export HISTCONTROL=ignoreboth
}

f_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
  fi
  export PATH="$SYS_PATH"

  export PATH="$HOME/bin:$PATH"
}

f_alias() {
  # shell
  alias s='source $HOME/.bashrc'
  alias h='history 20'
  alias j='jobs -l'
  alias where='type -all'

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

  alias ls="ls -F --color=auto -I 'NTUSER.*'"
  alias more='less'
  alias vi='vim'
}

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

#======================================================
# main
#======================================================
unalias -a
f_env
f_path
f_alias
