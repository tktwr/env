#!/bin/bash

bin_name=`basename $0`

g_args=""
g_where=""

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
  echo "  --in-prev-win         ... exec in prev win"
  echo "  --in-above-win        ... exec in above win"
  echo "  --in-new-tab          ... exec in new tab"
}

f_vimapi_exec() {
  printf '\e]51;["call","Tapi_Exec","%s"]\x07' "$1"
}

f_vimapi_exec_in_prev_win() {
  printf '\e]51;["call","Tapi_ExecInPrevWin","%s"]\x07' "$1"
}

f_vimapi_exec_in_above_win() {
  printf '\e]51;["call","Tapi_ExecInAboveWin","%s"]\x07' "$1"
}

f_vimapi_exec_in_new_tab() {
  printf '\e]51;["call","Tapi_ExecInNewTab","%s"]\x07' "$1"
}

f_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      --in-prev-win)
        g_where="_in_prev_win"
        ;;
      --in-above-win)
        g_where="_in_above_win"
        ;;
      --in-new-tab)
        g_where="_in_new_tab"
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
eval "f_vimapi_exec$g_where \"$g_args\""

