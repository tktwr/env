#!/bin/sh

bin_name=`basename $0`
top_dir=`pwd`

f_exec_in_dirs() {
  cmd="$1"
  shift
  dirs="$@"

  for i in $dirs; do
    echo "=== [$i] ==="
    cd "$i"
    eval "$cmd"
    echo
    echo
    cd $top_dir
  done
}

f_exec_in_dirs "$@"

