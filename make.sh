#!/bin/bash

source common.sh

#======================================================
# functions
#======================================================
f_default() {
  f_help
}

f_snap() {
  git-tar.sh ${MY_SNAP}
}

f_tags() {
  cd tags
  f_eval 'myctags.sh $MY_BIN/*.sh > tags.bin_sh'
  f_eval 'myctags.sh $MY_BIN/py/*.py > tags.bin_py'
  f_eval 'myctags.sh $MY_BASH/*.sh > tags.bash'
  f_eval 'myctags.sh $MY_VIM/*.vim $MY_VIM/plugin/*.vim $MY_VIM/vim-plug/*.vim > tags.vim'
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

