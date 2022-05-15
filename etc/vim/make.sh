#!/bin/bash

#======================================================
# dirs
#======================================================
GIT_DIRS="\
plugged/vim-winbuf-menu \
plugged/vim-bmk-menu \
plugged/vim-ide-style \
plugged/vim-memo \
"

#======================================================
# functions
#======================================================
f_all() {
  cp vimrc_all.vim $HOME/.vimrc
  cat vimrc_min.vim gvimrc_min.vim > $HOME/_vimrc
  cat vimrc_min.vim gvimrc_min.vim > $MY_HOME/_vimrc
}

f_min() {
  cp vimrc_min.vim $HOME/.vimrc
}

f_min_plug() {
  cat vimrc_min.vim vimrc_min_plug.vim > $HOME/.vimrc
}

#------------------------------------------------------
f_plug_status() {
  for-dir.sh "git status -s" ${GIT_DIRS}
}

f_plug_graph() {
  for-dir.sh "git graph -1" ${GIT_DIRS}
}

f_plug_tags() {
  for-dir.sh "./make.sh tags" ${GIT_DIRS}
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
  echo "plug_status ... git status for plugins"
  echo "plug_graph  ... git graph for plugins"
  echo "plug_tags   ... make tags for plugins"
  echo "----------- ... -----------------------------"
  echo "log         ... measure startuptime"
  echo "log_clean   ... clean log files"
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
