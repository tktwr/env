#!/bin/bash

#------------------------------------------------------
# util
#------------------------------------------------------
f_os_name() {
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)  echo "msys" ;;
    *WSL*)   echo "wsl" ;;
    *Linux*) echo "linux" ;;
    *)       echo "linux" ;;
  esac
}

#------------------------------------------------------
# env
#------------------------------------------------------
f_env_msys() {
  export MY_HOME="/c/Users/$USERNAME"
  export MY_PYTHON_EXE="python"
  export USER_PYTHON_HOME="$MY_HOME/AppData/Local/Programs/Python/Python39"
}

f_env_wsl() {
  export USERPROFILE=$(wslpath -aw "$HOME/WinHome")
  export MY_HOME="$HOME"
  export MY_PYTHON_EXE="python3"
}

f_env_linux() {
  export MY_HOME="$HOME"
  export MY_PYTHON_EXE="python3"
}

f_env_common() {
  export MY_CONFIG="$MY_HOME/MyConfig"
  export MY_REMOTE_CONFIG="$MY_CONFIG/tktwr.github"
  export MY_LOCAL_CONFIG="$MY_CONFIG/tktwr.local"
  export MY_PRIVATE_CONFIG="$MY_CONFIG/tktwr.private"

  export MY_ENV="$MY_REMOTE_CONFIG/env"
  export MY_BIN="$MY_ENV/bin"
  export MY_ETC="$MY_ENV/etc"
  export MY_VIM="$MY_ENV/etc/vim"

  export MY_FZY="$MY_ETC/fzy"
  export MY_COMMON_SETTING="$MY_CONFIG/local/common"
  export MY_DOTMY="$HOME/.my"
}

#------------------------------------------------------
# path
#------------------------------------------------------
f_path() {
  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
  fi

  export PATH="$SYS_PATH"
  export PATH="$MY_BIN:$PATH"

  if [ -n "$USER_PYTHON_HOME" ]; then
    export PATH="$USER_PYTHON_HOME:$PATH"
    export PATH="$USER_PYTHON_HOME/Scripts:$PATH"
  fi
}

#------------------------------------------------------
# setup
#------------------------------------------------------
export MY_OS_NAME=$(f_os_name)

f_env_$MY_OS_NAME
f_env_common
f_path

#------------------------------------------------------
# prompt
#------------------------------------------------------
export PS1="[\w]$ "

#------------------------------------------------------
# color
#------------------------------------------------------
export LS_COLORS="di=31:ln=31:tw=31:ow=31"
export LS_COLORS="$LS_COLORS:ex=35:*.sh=35"

#------------------------------------------------------
# alias
#------------------------------------------------------
unalias -a

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
alias vi='vim'
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

vim-which() { vim `which $*`; }
vim-where() { vim `which $*`; }

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
export MY_VIM_BMK="$MY_VIM/plugged/vim-bmk-menu"
export MY_VIM_IDE="$MY_VIM/plugged/vim-ide-style"
export PATH="$MY_VIM_IDE/bin:$MY_VIM_BMK/bin:$PATH"
source $MY_VIM_IDE/etc/bashrc
