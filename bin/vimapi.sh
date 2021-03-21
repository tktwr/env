#!/bin/bash

bin_name=`basename $0`

g_args=""

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help            ... print help"
  echo "  --filepath <filepath> ... filepath"
}

f_vimapi_exec() {
  #echo "$1"
  printf '\e]51;["call","Tapi_Exec","%s"]\x07' "$1"
}

f_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --filepath)
        shift
        p=$(cygpath -au $1)
        g_args="$g_args $p"
        ;;
      *)
        g_args="$g_args $1"
        ;;
    esac
    shift
  done
}

f_args "$@"
f_vimapi_exec "$g_args"

