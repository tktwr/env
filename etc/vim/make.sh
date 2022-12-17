#!/bin/bash

#======================================================
# functions
#======================================================
f_all() {
  cat vimrc_all.vim  > $HOME/.vimrc
  cat vimrc_zero.vim > $HOME/_vimrc
  cat vimrc_zero.vim > $SYS_WIN_HOME/_vimrc
}

f_min_plug() {
  cat vimrc_zero.vim vimrc_min_plug.vim > $HOME/.vimrc
}

f_min() {
  cat vimrc_zero.vim > $HOME/.vimrc
}

f_zero() {
  cat vimrc_zero.vim > $HOME/.vimrc
}

#------------------------------------------------------
f_log() {
  vim-log.sh
}

#------------------------------------------------------
f_help() {
  echo "all         ... full settings (default)"
  echo "min_plug    ... minimum settings with plugins"
  echo "min         ... minimum settings"
  echo "zero        ... minimum settings without any dependencies"
  echo "----------- ... -----------------------------"
  echo "log         ... measure startuptime"
  echo "----------- ... -----------------------------"
  echo "help        ... print this help"
}

f_default() {
  f_all
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
