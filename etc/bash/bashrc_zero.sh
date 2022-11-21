#!/bin/bash

#======================================================
# minimal bashrc without any dependencies
#======================================================
unalias -a

#======================================================
# functions
#======================================================
f_env() {
  export HISTCONTROL=ignoreboth

  # prompt
  export PS1="\u@\h[\w]\$ "

  # color
  export LS_COLORS="di=31:ln=31:tw=31:ow=31"
  export LS_COLORS="$LS_COLORS:ex=35:*.sh=35"
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

  # remap
  alias sudo='sudo -E'
  alias ls="ls -F --color=auto -I 'NTUSER.*'"
  alias more='less'

  # vim
  alias vi='vim'
  alias vim-none='/usr/bin/vim -u NONE'
  alias T2='vim -c "term" -c "only" -c "term"'
}

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

#======================================================
# main
#======================================================
f_env
f_path
f_alias
