#!/bin/bash

#======================================================
# minimal bashrc
#======================================================
source_file() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

source_file $HOME/.my/hostname.sh

#======================================================
# functions
#======================================================
f_min_env() {
  # prompt
  export PS1="$MY_HOST_NAME:$MY_OS_NAME[\w]\$ "

  # dir
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

  case $MY_OS_NAME in
    msys|gitbash)
      export MY_BIN_WIN=$(cygpath -am $MY_BIN)
      export MY_VIM_WIN=$(cygpath -am $MY_VIM)
      ;;
  esac
}

f_min_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
  fi
  export PATH="$SYS_PATH"
  export PATH="$MY_BIN:$PATH"
}

#------------------------------------------------------
# python
#------------------------------------------------------
f_min_python_win() {
  export MY_PYTHON_EXE="python"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export USER_PYTHON_HOME="$SYS_WIN_HOME/AppData/Local/Programs/Python/Python310"
  export PATH="$USER_PYTHON_HOME:$PATH"
  export PATH="$USER_PYTHON_HOME/Scripts:$PATH"
}

f_min_python_linux() {
  export MY_PYTHON_EXE="python3"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
}

f_min_python() {
  if [ -z "$SYS_PYTHONPATH" ]; then
    export SYS_PYTHONPATH=$PYTHONPATH
  fi
  export PYTHONPATH="$SYS_PYTHONPATH"

  case $MY_OS_NAME in
    msys|gitbash)
      f_min_python_win
      ;;
    *)
      f_min_python_linux
      ;;
  esac
}

#------------------------------------------------------
# alias
#------------------------------------------------------
f_min_alias() {
  alias G='git graph -6'
  alias GA='git graph -6 --all'

  # cd
  alias cd.bin='cd $MY_BIN'
  alias cd.etc='cd $MY_ETC'
  alias cd.vim='cd $MY_VIM'
  alias cd.common='cd $MY_COMMON_SETTING'
}

#======================================================
# main
#======================================================
f_min_env
f_min_path
f_min_python
f_min_alias
#------------------------------------------------------
# vim plugin
#------------------------------------------------------
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc.alias
source_file $MY_VIM/plugged/vim-memo/etc/bashrc
