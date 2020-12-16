#!/bin/bash

source $HOME/.my/hostname
source $HOME/.bashrc.env

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

echo 'source $HOME/.vimrc.env'
f_cat_vimrc $MY_REMOTE_CONFIG/env/etc/vim
f_cat_vimrc $MY_LOCAL_CONFIG/env/etc/vim
f_cat_vimrc $MY_PRIVATE_CONFIG/env/etc/vim

