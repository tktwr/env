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
  echo "  --clean    ... clean"
}

f_init() {
  ./dot.sh --init
  f_make --min
}

f_make() {
  ./dot.sh --common-files --cp

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
      --init)
        f_init
        ;;
      --all)
        f_make --all
        ;;
      --min)
        f_make --min
        ;;
      --clean)
        f_make --clean
        ;;
    esac
  done
}

f_args "$@"
