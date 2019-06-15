#!/bin/bash

export MY_VIM

f_set_default() {
  if [ -z "$MY_VIM" ]; then
    MY_VIM='~/.vim'
  fi
}

f_expand_dir() {
  local os=$1
  local name=$2
  local val=$3

  if [ -x /usr/bin/cygpath ]; then
    if [ "$os" = "unix" ]; then
      dir=`cygpath -u $val`
    elif [ "$os" = "win" ]; then
      dir=`cygpath -m $val`
    fi
  else
    dir=$val
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

target_os=$1
target_shell=$2

case $target_shell in
  MINGW64)
    GIT_EXE=$MY_REMOTE_CONFIG/env/bin/shell.$MY_SHELL_NAME/git
    ;;
  gitbash)
    GIT_EXE=git
    ;;
esac

f_set_default

f_expand_dir $target_os MY_VIM $MY_VIM
f_expand_dir $target_os MY_REMOTE_CONFIG $MY_REMOTE_CONFIG
f_expand_dir $target_os MY_LOCAL_CONFIG $MY_LOCAL_CONFIG
f_expand_dir $target_os MY_OPT $MY_OPT
f_expand_dir $target_os MY_GIT_EXE $GIT_EXE

f_make_vimrc
f_make_local_vimrc

