#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
  echo
}

f_snap() {
  git-tar.sh ${MY_SNAP}
}

f_tags() {
  cd tags
  myctags.sh $MY_BIN/*.sh > tags.bin_sh
  myctags.sh $MY_BIN/py/*.py > tags.bin_py
  myctags.sh $MY_BASH/*.sh > tags.bash
  myctags.sh $MY_VIM/*.vim $MY_VIM/plugin/*.vim $MY_VIM/vim-plug/*.vim > tags.vim
}

f_help() {
  echo "snap    ... make a snapshot"
  echo "tags    ... make tags"
  echo "help    ... print help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

