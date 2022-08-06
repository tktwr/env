#!/bin/bash

#------------------------------------------------------
# util
#------------------------------------------------------
f_os_name() {
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)  echo "msys"  ;;
    *)       echo "linux" ;;
  esac
}

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
f_env_msys() {
  export SYS_WIN_HOME="/c/Users/$USERNAME"
  export SYS_CONFIG_HOME="/c/Users/$USERNAME"
}

f_env_linux() {
  export SYS_WIN_HOME=$(realpath "$HOME/WinHome")
  export SYS_CONFIG_HOME="$HOME"
}

f_env_common() {
  export MY_CONFIG="$SYS_CONFIG_HOME/MyConfig"
  export MY_REMOTE_CONFIG="$MY_CONFIG/rconfig"
  export MY_LOCAL_CONFIG="$MY_CONFIG/lconfig"
  export MY_PRIVATE_CONFIG="$MY_CONFIG/pconfig"

  export MY_ENV="$MY_REMOTE_CONFIG/env"
  export MY_BIN="$MY_ENV/bin"
  export MY_ETC="$MY_ENV/etc"
  export MY_VIM="$MY_ENV/etc/vim"

  export MY_FZY="$MY_ETC/fzy"
  export MY_COMMON_SETTING="$MY_CONFIG/lconfig/common"
  export MY_DOTMY="$HOME/.my"

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

#------------------------------------------------------
# print
#------------------------------------------------------
f_print_env() {
  echo "SYS_WIN_HOME    = $SYS_WIN_HOME"
  echo "SYS_CONFIG_HOME = $SYS_CONFIG_HOME"
  echo "PATH            = $PATH"
  echo "PYTHONPATH      = $PYTHONPATH"
  echo "MY_PYTHON_EXE   = $MY_PYTHON_EXE"
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
export MY_OS_NAME=$(f_os_name)

f_env_${MY_OS_NAME}
f_env_common
f_path
f_python_${MY_OS_NAME}
#f_print_env

unalias -a
f_alias

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc
source_file $MY_VIM/plugged/vim-ide-style/etc/bashrc.alias
source_file $MY_VIM/plugged/vim-memo/etc/bashrc
