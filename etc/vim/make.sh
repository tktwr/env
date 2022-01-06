#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
  cp vimrc_all.vim $HOME/.vimrc
  cp gvimrc_min.vim $HOME/_vimrc
  cp gvimrc_min.vim $MY_HOME/_vimrc
}

f_min() {
  cp vimrc_min.vim $HOME/.vimrc
}

f_log() {
  f_log_clean
	vim -c "q" --startuptime $HOME/vim_log.txt
	vim -u NONE -c "q" --startuptime $HOME/vim_log_zero.txt
}

f_log_clean() {
	rm -f $HOME/vim_log.txt
	rm -f $HOME/vim_log_zero.txt
}

f_help() {
  echo "default"
  echo "min"
  echo "log"
  echo "log_clean"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

