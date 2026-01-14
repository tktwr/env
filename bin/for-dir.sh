#!/bin/bash

bin_name=`basename $0`
top_dir=`pwd`

f_print_entry() {
  echo "=== [$1]($2) ==="
}
f_exec_in_dirs() {
  cmd="$1"
  shift
  dirs="$@"

  for i in $dirs; do
    if [ -d $i ]; then
      f_print_entry "$i" "$cmd" | coloring.py
      vimapi-cd "$i"
      eval "$cmd"
      vimapi-cd "$top_dir"
    fi
  done
}

f_exec_in_dirs "$@"

