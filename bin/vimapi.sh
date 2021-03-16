#!/bin/bash

bin_name=`basename $0`

g_type=""
g_args="$PWD"

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

f_nerdtree() {
  printf '\e]51;["call","Tapi_NERDTree","%s"]\x07' "$1"
}

f_edit() {
  printf '\e]51;["call","Tapi_Edit","%s"]\x07' "$1"
}

f_vimapi() {
  case $g_type in
    dir)
      f_nerdtree $g_args
      ;;
    file)
      f_edit $g_args
      ;;
  esac
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        exit
        ;;
      -d|--dir)
        g_type="dir"
        ;;
      -f|--file)
        g_type="file"
        ;;
      *)
        g_args="$(cygpath -au $i)"
        ;;
    esac
  done
}

f_args "$@"
f_vimapi
