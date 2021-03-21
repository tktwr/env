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
  echo "  -h, --help        ... print help"
  echo "  --nerdtree <dir>  ... nerdtree"
  echo "  --edit <file>     ... edit"
  echo "  --tabedit <file>  ... tabedit"
  echo "  --resize <height> ... tabedit"
}

f_nerdtree() {
  printf '\e]51;["call","Tapi_NERDTree","%s"]\x07' "$1"
}

f_edit() {
  printf '\e]51;["call","Tapi_Edit","%s"]\x07' "$1"
}

f_tabedit() {
  printf '\e]51;["call","Tapi_TabEdit","%s"]\x07' "$1"
}

f_resize() {
  printf '\e]51;["call","Tapi_Resize","%s"]\x07' "$1"
}

f_get_path() {
  echo "$(cygpath -au $1)"
}

f_vimapi() {
  case $g_type in
    nerdtree)
      f_nerdtree $(f_get_path $g_args)
      ;;
    edit)
      f_edit $(f_get_path $g_args)
      ;;
    tabedit)
      f_tabedit $(f_get_path $g_args)
      ;;
    resize)
      f_resize $g_args
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
      --nerdtree)
        g_type="nerdtree"
        ;;
      --edit)
        g_type="edit"
        ;;
      --tabedit)
        g_type="tabedit"
        ;;
      --resize)
        g_type="resize"
        ;;
      *)
        g_args="$i"
        ;;
    esac
  done
}

f_args "$@"
f_vimapi

