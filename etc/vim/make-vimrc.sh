#!/bin/bash

export MY_VIM

f_make_vim_header() {
  if [ -z "$MY_VIM" ]; then
    MY_VIM='~/.vim'
    dir=$MY_VIM
  else
    if [ "$1" = "unix" ]; then
      dir=`cygpath -au "$MY_VIM"`
    elif [ "$1" = "win" ]; then
      dir=`cygpath -am "$MY_VIM"`
    fi
  fi
  echo "let \$MY_VIM=\"$dir\""
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

f_make_vim_header $1
f_make_vimrc
f_make_local_vimrc

