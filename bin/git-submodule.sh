#!/bin/bash

g_base_dir=$(pwd)
g_bin_name=`basename $0`
g_args=""

f_help() {
  echo "NAME"
  echo "  $g_bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $g_bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help            ... print help"
}

f_curr() {
  echo "=== [$g_base_dir] ==="
  git graph -4
  echo
  echo "---"
  git status -s
}

f_submodule() {
  dirs=$(git submodule | awk '{print $2}')
  for i in $dirs; do
    echo "====== [$i] ======"
    git submodule | grep "$i"
    cd $i
    git graph -2
    echo
    echo "---"
    git status -s
    cd $g_base_dir
  done
}

f_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      *)
        g_args="$g_args $1"
        ;;
    esac
    shift
  done
}

f_args "$@"
f_curr
f_submodule

