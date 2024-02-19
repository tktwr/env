#!/bin/bash

source $HOME/.my/hostname.sh

#======================================================
# minimal bashrc without any dependencies
#======================================================
f_zero_env() {
  export COLUMNS
  export HISTCONTROL=ignoreboth
  export PS1="\u@\h[\w]\$ "

  # color
  export LS_COLORS="di=31:ln=31:tw=31:ow=31"
  export LS_COLORS="$LS_COLORS:ex=35:*.sh=35"
}

f_zero_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
    export SYS_PYTHONPATH=$PYTHONPATH
  fi
  export PATH="$SYS_PATH"
  export PATH="$HOME/bin:$PATH"
  export PYTHONPATH="$SYS_PYTHONPATH"
}

f_zero_alias() {
  unalias -a

  # source
  alias s='source $HOME/.bashrc'
  alias s.='source .venv/bin/activate'

  # shell
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

  # git
  alias gs='git status'
  alias gS='git status -s'
  alias gd='git diff'
  alias gD='git diff --staged'
  alias gf='git fetch'
  alias gg='git graph'
  alias gb='git branch'
  alias gt='git tag'

  alias gA='git add'
  alias gAu='git add -u'
  alias gAC='git commit -a -m'
  alias gC='git commit -m'

  alias gR='git reset --hard'
  alias gRom='git reset --hard origin/master'
  alias gPom='git push origin master'

  alias G='git log --graph --oneline -6'
  alias GA='git log --graph --oneline -6 --all'

  # vim
  alias vi='vim'
  alias vim-none='/usr/bin/vim -u NONE'
  alias T2='vim -c "term" -c "only" -c "term"'
  alias V2='vim -c "term" -c "only" -c "vert term"'
}

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

#======================================================
# main
#======================================================
f_zero_env
f_zero_path
f_zero_alias

f_venv_activate
