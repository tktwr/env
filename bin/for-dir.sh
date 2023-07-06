#!/bin/bash

bin_name=`basename $0`
top_dir=`pwd`

f_exec_in_dirs() {
  cmd="$1"
  shift
  dirs="$@"

  for i in $dirs; do
    if [ -d $i ]; then
      echo "=== [$i]($cmd) ==="
      cd "$i"
      eval "$cmd"
      cd "$top_dir"
    fi
  done
}

f_exec_in_dirs "$@"

