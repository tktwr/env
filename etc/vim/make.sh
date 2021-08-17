#!/bin/bash

bin_name=`basename $0`

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
}

f_install() {
	cp vimrc.all.vim $HOME/.vimrc
  cp min_gvimrc.vim $HOME/_vimrc
}

f_install_min() {
	cp min_vimrc.vim $HOME/.vimrc
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        ;;
      --all)
        f_install
        ;;
      --min)
        f_install_min
        ;;
    esac
  done
}

f_args "$@"
