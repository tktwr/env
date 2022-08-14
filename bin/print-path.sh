#!/bin/bash

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name"
  echo
}

#------------------------------------------------------
f_format_path_unix() {
  sed 's+:+\n+g'
}

f_format_path_win() {
  sed 's+;+\n+g'
}

#------------------------------------------------------
f_print_sys_path() {
  echo "=== [SYS_PATH] ==="
  echo "$SYS_PATH" | f_format_path_unix
}

f_print_path() {
  echo "=== [PATH] ==="
  echo "$PATH" | f_format_path_unix
}

f_print_python_path() {
  echo "=== [PYTHONPATH] ==="
  case $MY_OS_NAME in
    msys|gitbash)
      echo "$PYTHONPATH" | f_format_path_win
      ;;
    *)
      echo "$PYTHONPATH" | f_format_path_unix
      ;;
  esac
}

f_print_which() {
  cmd=$1
  which $cmd 2> /dev/null
  $cmd --version 2> /dev/null | head -1
}

f_print_which_all() {
  echo "=== [which] ==="
  BIN_NAMES="\
  python \
  pip \
  python3 \
  pip3 \
  pyls \
  pylint \
  flake8 \
  clang \
  clangd \
  node \
  cmake \
  make \
  git \
  vim \
  "
  for i in $BIN_NAMES; do
    f_print_which $i
  done
}

f_print_all() {
  f_print_sys_path
  f_print_path
  f_print_python_path
  f_print_which_all
}

f_print_all
