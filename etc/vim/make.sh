#!/bin/bash

#======================================================
# functions
#======================================================
f_all() {
  cp vimrc_all.vim $HOME/.vimrc
  cat vimrc_min.vim gvimrc_min.vim > $HOME/_vimrc
  cat vimrc_min.vim gvimrc_min.vim > $SYS_WIN_HOME/_vimrc
}

f_min() {
  cp vimrc_min.vim $HOME/.vimrc
}

f_min_plug() {
  cat vimrc_min.vim vimrc_min_plug.vim > $HOME/.vimrc
}

#------------------------------------------------------
f_log() {
  f_log_clean
  vim -c "q" --startuptime $HOME/vim_log.txt
  vim -u NONE -c "q" --startuptime $HOME/vim_log_zero.txt
}

f_log_clean() {
  rm -f $HOME/vim_log.txt
  rm -f $HOME/vim_log_zero.txt
}

#------------------------------------------------------
f_help() {
  echo "all         ... full settings (default)"
  echo "min         ... minimum settings"
  echo "min_plug    ... minimum settings with plugins"
  echo "----------- ... -----------------------------"
  echo "log         ... measure startuptime"
  echo "log_clean   ... clean log files"
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
eval "f_$func_name"
