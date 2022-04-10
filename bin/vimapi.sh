#!/bin/bash

bin_name=`basename $0`

g_tapi="Tapi_Exec"
g_func=""
g_filepath=""
g_winnr=
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
  echo "  --in-prev-win         ... exec in prev win"
  echo "  --in-above-win        ... exec in above win"
  echo "  --in-new-tab          ... exec in new tab"
  echo "  --edit-dir <dir>      ... edit dir"
  echo "  --edit <file>         ... edit file"
  echo "  --filepath <filepath> ... set filepath"
  echo "  --winnr <nr>          ... set winnr"
}

f_vimapi() {
  printf '\e]51;["call","%s","%s"]\x07' "$g_tapi" "$1"
}

f_vimapi_dir() {
  local dir="${1:-$PWD}"
  local dir=$(cygpath -au "$dir")
  local winnr=${2:-1}
  if [ -n "$dir" ]; then
    f_vimapi "call BmkEditDir('$dir/', $winnr)"
  fi
}

f_vimapi_edit() {
  local file=$(cygpath -au "$1")
  local winnr="${2:--1}"
  if [ -n "$file" ]; then
    f_vimapi "call BmkEditFile('$file', $winnr)"
  fi
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --in-prev-win)
        g_tapi="Tapi_ExecInPrevWin"
        ;;
      --in-above-win)
        g_tapi="Tapi_ExecInAboveWin"
        ;;
      --in-new-tab)
        g_tapi="Tapi_ExecInNewTab"
        ;;
      --edit-dir)
        g_func="BmkEditDir"
        ;;
      --edit)
        g_func="BmkEditFile"
        ;;
      --filepath)
        shift
        g_filepath=$(cygpath -au "$1")
        ;;
      --winnr)
        shift
        g_winnr=$1
        ;;
      *)
        if [ -z $g_args ]; then
          g_args="$1"
        else
          g_args="$g_args $1"
        fi
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "g_tapi     = $g_tapi"
  echo "g_func     = $g_func"
  echo "g_filepath = $g_filepath"
  echo "g_winnr    = $g_winnr"
  echo "g_args     = $g_args"
}

f_parse_args "$@"
f_print_args

case $g_func in
  BmkEditDir)
    f_vimapi_dir "$g_args" $g_winnr
    ;;
  BmkEditFile)
    f_vimapi_edit "$g_args" $g_winnr
    ;;
  *)
    f_vimapi "$g_args"
    ;;
esac

