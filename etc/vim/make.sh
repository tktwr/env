#!/bin/bash

#======================================================
# dirs
#======================================================
GIT_DIRS="\
plugged/vim-winbuf-menu \
plugged/vim-bmk-menu \
plugged/vim-ide-style \
"

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

f_min_plug() {
  cat vimrc_min.vim vimrc_min_plug.vim > $HOME/.vimrc
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

f_plug_graph() {
	for-dir.sh "git graph -1" ${GIT_DIRS}
}

f_plug_status() {
	for-dir.sh "git status -s" ${GIT_DIRS}
}

f_help() {
  echo "default"
  echo "min"
  echo "min_plug"
  echo "log"
  echo "log_clean"
  echo "plug_graph"
  echo "plug_status"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

