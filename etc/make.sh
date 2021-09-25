#!/bin/bash

#======================================================
# functions
#======================================================
f_default() {
  ./dot.sh --common-files --cp

  cd bash
  ./make.sh
  cd ..

  cd vim
  ./make.sh
  cd ..
}

f_min() {
  cp bash/bashrc_min.sh $HOME/.bashrc
  cp vim/vimrc_min.vim $HOME/.vimrc
}

f_init() {
  ./dot.sh --init
  f_min
}

f_backup() {
	./dot.sh --backup
}

f_tags() {
	cd ..
  ./make.sh tags
}

f_cmp() {
	./dot.sh --all-files --cmp
}

f_vimdiff() {
	./dot.sh --all-files --vimdiff
}

f_vimdirdiff() {
	./dot.sh --all-files --vimdirdiff
}

f_help() {
  echo "default"
  echo "min"
  echo "init"
  echo "backup"
  echo "tags"
  echo "cmp"
  echo "vimdiff"
  echo "vimdirdiff"
  echo "help"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"

