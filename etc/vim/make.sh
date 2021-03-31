#!/bin/bash

bin_name=`basename $0`

source $HOME/.my/hostname
source $HOME/.bashrc.env

BUILD_DIR=build

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
  echo "  --all      ... all"
  echo "  --min      ... min"
  echo "  --clean    ... clean"
}

f_make() {
  mkdir -p $BUILD_DIR
  ./make.00.vimrc.env.sh unix > $BUILD_DIR/.vimrc.env
  ./make.01.vimrc.sh > $BUILD_DIR/.vimrc
}

f_install() {
	cp $BUILD_DIR/.vimrc.env $HOME
	cp $BUILD_DIR/.vimrc $HOME
  cp min_gvimrc.vim $HOME/_vimrc
  cp min_gvimrc.vim $MY_HOME/_vimrc
}

f_install_min() {
	cp min_vimrc.vim $HOME/.vimrc
}

f_clean() {
	rm -rf $BUILD_DIR
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        ;;
      --all)
        f_make
        f_install
        ;;
      --min)
        f_install_min
        ;;
      --clean)
        f_clean
        ;;
    esac
  done
}

f_args "$@"
