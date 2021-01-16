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
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        exit
        ;;
    esac
  done
}

f_args "$@"
