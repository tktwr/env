#!/bin/sh

bin_name=`basename $0`
COMMAND=echo

f_find() {
  find . -type d -name 'build*' -prune -exec $COMMAND {} \;
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
  echo "  -p, --print      print dirs"
  echo "  -rm              remove dirs"
}

f_args() {
  for i in $*; do
    case $i in
      -h|--help)
        f_help
        ;;
      -p|--print)
        COMMAND="echo"
        ;;
      -rm)
        COMMAND="rm -rf"
        ;;
    esac
  done
}

f_args $*
f_find

