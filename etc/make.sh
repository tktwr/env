#!/bin/bash

export PATH=$HOME/AppData/Local/Programs/Python/Python38:$PATH

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
  echo "  --clean    ... clean"
}

f_dot() {
  ./dot.sh --common-files --cp
}

f_make() {
  cd bash
  ./make.sh "$@"
  cd ..

  cd vim
  ./make.sh "$@"
  cd ..
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        ;;
      --all)
        f_dot
        f_make --all
        ;;
      --min)
        f_dot
        f_make --min
        ;;
      --clean)
        f_make --clean
        ;;
    esac
  done
}

f_args "$@"
