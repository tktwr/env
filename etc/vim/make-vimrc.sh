#!/bin/bash

source $HOME/.my/hostname

f_expand_dir() {
  local os="$1"
  local name="$2"
  local val="$3"

  if [ -x /usr/bin/cygpath ]; then
    if [ "$os" = "unix" ]; then
      dir=`cygpath -u "$val"`
    elif [ "$os" = "win" ]; then
      dir=`cygpath -m "$val"`
    fi
  else
    dir="$val"
  fi

  echo "let \$$name=\"$dir\""
  #echo "let \$$name=expand(\"$dir\")"
}

f_set_env_vars() {
  local target_os=$1
  local target_shell=$2

  case $target_shell in
    MINGW64)
      GIT_EXE=$MY_REMOTE_CONFIG/env/bin/shell.$MY_SHELL_NAME/git
      ;;
    gitbash|termux|bash)
      GIT_EXE=git
      ;;
  esac

  f_expand_dir $target_os MY_VIM $MY_VIM
  f_expand_dir $target_os MY_REMOTE_CONFIG $MY_REMOTE_CONFIG
  f_expand_dir $target_os MY_LOCAL_CONFIG $MY_LOCAL_CONFIG
  f_expand_dir $target_os MY_OPT $MY_OPT
  f_expand_dir $target_os MY_GIT_EXE $GIT_EXE
}

f_cat_vimrc() {
  local DIR=$1
  if [ ! -d $DIR ]; then
    return
  fi

  cd $DIR

  local files="vimrc.??.*.vim"
  local I

  for I in $files; do
    if [ -f $I ]; then
      cat $I
    fi
  done
}

f_set_env_vars $1 $2
f_cat_vimrc $MY_REMOTE_CONFIG/env/etc/vim
f_cat_vimrc $MY_LOCAL_CONFIG/env/etc/vim
f_cat_vimrc $MY_PRIVATE_CONFIG/env/etc/vim

