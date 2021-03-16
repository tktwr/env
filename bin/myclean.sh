#!/bin/bash

bin_name=`basename $0`

opt=''

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help    ... print help"
  echo "  -py, --python ... print python dirs"
  echo "  -b, --build   ... print build dirs"
  echo "  -o, --output  ... print output dirs"
  echo "  -rm           ... remove dirs"
}

f_clean() {
  eval "find . $opt"
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -rm)
        opt="$opt -exec rm -rf {} +"
        ;;
      -py|--python)
        opt="$opt -type d -name '__pycache__' -prune"
        ;;
      -b|--build)
        opt="$out -type d -name 'build*' -prune"
        ;;
      -o|--output)
        opt="$out -type d -name '_output' -prune"
        ;;
      -h|--help)
        f_help
        exit
        ;;
    esac
  done
}

f_args "$@"
f_clean

