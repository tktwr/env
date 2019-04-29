#!/bin/bash

export MY_VIM

f_set_default() {
  if [ -z "$MY_VIM" ]; then
    MY_VIM='~/.vim'
  fi
}

f_make_env_var() {
  local os=$1
  local name=$2
  local val=$3
  if [ "$os" = "unix" ]; then
    dir=`cygpath -u $val`
  elif [ "$os" = "win" ]; then
    dir=`cygpath -m $val`
  fi
  echo "let \$$name=\"$dir\""
}

f_make_vimrc() {
  cat vimrc.??.*.vim
}

f_make_local_vimrc() {
  local local_vim_dir=$MY_LOCAL_CONFIG/env/etc/vim
  local files="vimrc"
  local i
  for i in $files; do
    i=$local_vim_dir/$i
    if [ -f $i ]; then
      cat $i
    fi
  done
}

f_set_default
f_make_env_var $1 MY_VIM $MY_VIM
f_make_env_var $1 MY_REMOTE_CONFIG $MY_REMOTE_CONFIG
f_make_env_var $1 MY_LOCAL_CONFIG $MY_LOCAL_CONFIG
f_make_env_var $1 MY_OPT $MY_OPT
f_make_vimrc
f_make_local_vimrc

