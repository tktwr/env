#!/bin/bash

bin_name=`basename $0`
top_dir=`pwd`
g_esc=1

f_print_dir() {
  if [ $g_esc -eq 1 ]; then
    line="\\e[33m$*\\e[0m"
    line=$(echo "$line" | sed 's/rconfig/\\e[32m&\\e[33m/')
    line=$(echo "$line" | sed 's/lconfig/\\e[34m&\\e[33m/')
    line=$(echo "$line" | sed 's/pconfig/\\e[35m&\\e[33m/')
    echo -e "$line"
  else
    echo "$*"
  fi
}
f_print_cmd() {
  if [ $g_esc -eq 1 ]; then
    echo -e "\e[31m$*\e[0m"
  else
    echo "$*"
  fi
}
f_print_entry() {
  echo -e "=== [$(f_print_dir $1)]($(f_print_cmd $2)) ==="
}
f_exec_in_dirs() {
  cmd="$1"
  shift
  dirs="$@"

  for i in $dirs; do
    if [ -d $i ]; then
      f_print_entry "$i" "$cmd"
      cd "$i"
      eval "$cmd"
      cd "$top_dir"
    fi
  done
}

f_exec_in_dirs "$@"

