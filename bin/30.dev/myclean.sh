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
      -h|--help)
        f_help
        exit
        ;;
      --pycache-dir)
        opt="$opt -type d -name '__pycache__' -prune"
        ;;
      --build-dir)
        opt="$opt -type d -name 'build*' -prune"
        ;;
      --output-dir)
        opt="$opt -type d -name '_output' -prune"
        ;;
      --doxygen-dir)
        opt="$opt -type d -name 'doxygen' -prune"
        ;;
      --blender-backup)
        opt="$opt -type f -name '*.blend1'"
        ;;
      -rm)
        opt="$opt -print -exec rm -rf {} +"
        ;;
    esac
  done
}

f_args "$@"
f_clean

