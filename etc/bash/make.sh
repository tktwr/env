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
	./make.env.sh > $HOME/.bashrc.env
	cp bashrc.all.sh $HOME/.bashrc
}

f_install_min() {
	cp bashrc.min.sh $HOME/.bashrc
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
