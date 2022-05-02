#!/bin/bash

#======================================================
# functions
#======================================================
f_sub() {
  cd $1
  ./make.sh $2
  cd ..
}

f_all() {
  ./dot.sh --common-files --cp
  f_sub bash
  f_sub vim
}

f_min() {
  f_sub bash min
  f_sub vim min
}

f_test() {
  f_sub bash min
  f_sub vim min_plug
}

#------------------------------------------------------
f_backup() {
	./dot.sh --backup
}

f_init() {
  ./dot.sh --init
  f_min
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

#------------------------------------------------------
f_help() {
  echo "default"
  echo "all"
  echo "min"
  echo "test"
  echo "backup"
  echo "init"
  echo "tags"
  echo "cmp"
  echo "vimdiff"
  echo "vimdirdiff"
  echo "help"
}

f_default() {
  f_all
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
eval "f_$func_name"
