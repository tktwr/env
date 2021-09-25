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
	ctags -f tags.bin.sh  bin/*.sh
	ctags -f tags.bin.py  bin/py/*.py
	ctags -f tags.etc.sh  etc/bash/*.sh
	ctags -f tags.etc.vim etc/vim/*.vim etc/vim/plugin/*.vim etc/vim/vim-plug/*.vim
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

