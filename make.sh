#!/bin/bash

source common.sh

#======================================================
# functions
#======================================================
f_snap() {
  fname=$(git-tar.sh)
  if [ -d "$MY_SNAP" ]; then
    echo "$fname $MY_SNAP"
    mv $fname $MY_SNAP
  fi
}

f_tags() {
  f_eval 'myctags.sh bin/*.sh > .tags.bin_sh'
  f_eval 'myctags.sh bin/py/*.py > .tags.bin_py'
  f_eval 'myctags.sh etc/bash/*.sh > .tags.bash'

  vim_files='\
    etc/vim/*.vim \
    etc/vim/vim-plug/*.vim \
    etc/vim/plugin \
    etc/vim/plugged/vim-winbuf-menu \
    etc/vim/plugged/vim-bmk-menu \
    etc/vim/plugged/vim-ide-style \
    etc/vim/plugged/vim-memo \
    '
  f_eval "myctags.sh $vim_files > .tags.vim"
}

#------------------------------------------------------
f_help() {
  echo "snap ... make a snapshot"
  echo "tags ... make tags"
  echo "help ... print this help (default)"
}

f_default() {
  f_help
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

