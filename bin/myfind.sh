#!/bin/bash

bin_name=`basename $0`
PATTERN=""
COMMAND=""

f_find() {
  echo "find . $PATTERN $COMMAND"
  eval "find . $PATTERN $COMMAND"
}

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help       print help"
  echo "  -b, --build      print build dirs"
  echo "  -rm              remove dirs"
}

f_args() {
  for i in $*; do
    case $i in
      -h|--help)
        f_help
        exit
        ;;
      -b|--build)
        PATTERN="-type d -name 'build*' -prune"
        ;;
      -rm)
        COMMAND="-exec rm -rf {} \;"
        ;;
    esac
  done
}

f_args "$@"
f_find

