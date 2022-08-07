#!/bin/bash

#------------------------------------------------------
# util
#------------------------------------------------------
source_file() {
  local files="$@"

  for i in $files; do
    if [ -f $i ]; then
      source $i
    fi
  done
}

#------------------------------------------------------
# env
#------------------------------------------------------
f_env() {
  export MY_DOTMY="$SYS_LOCAL_HOME/.my"
  export MY_ENV="$SYS_ROAMING_HOME/env"
  export MY_REMOTE_CONFIG="$SYS_CONFIG_HOME/rconfig"
  export MY_LOCAL_CONFIG="$SYS_CONFIG_HOME/lconfig"
  export MY_PRIVATE_CONFIG="$SYS_CONFIG_HOME/pconfig"
  export MY_COMMON_SETTING="$MY_LOCAL_CONFIG/common"

  export MY_BIN="$MY_ENV/bin"
  export MY_ETC="$MY_ENV/etc"
  export MY_VIM="$MY_ETC/vim"
  export MY_FZY="$MY_ETC/fzy"

  #------------------------------------------------------
  # prompt
  #------------------------------------------------------
  export PS1="[\w]$ "

  #------------------------------------------------------
  # color
  #------------------------------------------------------
  export LS_COLORS="di=31:ln=31:tw=31:ow=31"
  export LS_COLORS="$LS_COLORS:ex=35:*.sh=35"
}

#------------------------------------------------------
# path
#------------------------------------------------------
f_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
    export SYS_PYTHONPATH=$PYTHONPATH
  fi

  export PATH="$SYS_PATH"
  export PYTHONPATH="$SYS_PYTHONPATH"

  export PATH="$MY_BIN:$PATH"
}

#------------------------------------------------------
# python
#------------------------------------------------------
f_python_msys() {
  export MY_BIN_WIN=$(cygpath -am $MY_BIN)
  export MY_PYTHON_EXE="python"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export USER_PYTHON_HOME="$SYS_WIN_HOME/AppData/Local/Programs/Python/Python39"
  export PATH="$USER_PYTHON_HOME:$PATH"
  export PATH="$USER_PYTHON_HOME/Scripts:$PATH"
}

f_python_linux() {
  export MY_PYTHON_EXE="python3"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
}

f_python() {
  case $MY_OS_NAME in
    msys|gitbash)
      f_python_msys
      ;;
    wsl|linux)
      f_python_linux
      ;;
  esac
}

#------------------------------------------------------
# print
#------------------------------------------------------
f_print_env() {
  echo "SYS_WIN_HOME     = $SYS_WIN_HOME"
  echo "SYS_LOCAL_HOME   = $SYS_LOCAL_HOME"
  echo "SYS_ROAMING_HOME = $SYS_ROAMING_HOME"
  echo "SYS_CONFIG_HOME  = $SYS_CONFIG_HOME"
  echo "SYS_SHARE_HOME   = $SYS_SHARE_HOME"
  echo "PATH             = $PATH"
  echo "PYTHONPATH       = $PYTHONPATH"
  echo "MY_PYTHON_EXE    = $MY_PYTHON_EXE"
  which $MY_PYTHON_EXE
}

#------------------------------------------------------
# alias
#------------------------------------------------------
f_alias() {
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
  alias ls="ls -F --color=auto -I 'NTUSER.*'"
  alias more='less'

  alias gs='git status'
  alias gd='git diff'
  alias gf='git fetch'
  alias gA='git add'
  alias gAu='git add -u'
  alias gR='git reset --hard'
  alias G='git graph -6'
  alias GA='git graph -6 --all'

  alias cd.bin='cd $MY_BIN'
  alias cd.etc='cd $MY_ETC'
  alias cd.vim='cd $MY_VIM'

  alias vi='vim'
  alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
}

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

#======================================================
# setup
#======================================================
source_file $HOME/.my/hostname

f_env
f_path
f_python
#f_print_env

unalias -a
f_alias

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc.alias
source_file $MY_VIM/plugged/vim-memo/etc/bashrc
