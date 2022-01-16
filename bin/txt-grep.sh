#!/bin/bash

bin_name=`basename $0`

g_word=""
g_dirs=""

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] word file|dir..."
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print help"
}

f_parse_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      *)
        if [ -z "$g_word" ]; then
          g_word="$1"
        else
          if [ -z "$g_dirs" ]; then
            g_dirs="$1"
          else
            g_dirs="$g_dirs $1"
          fi
        fi
        ;;
    esac
    shift
  done
}

f_print_args() {
  echo "== [args] ============================================="
  echo "word: $g_word"
  echo "dirs: $g_dirs"
  echo "======================================================="
}

f_check_args() {
  if [ -z "$g_word" ]; then
    f_help
    exit
  fi
}

f_run() {
  if [ -n "$g_word" ]; then
    grep "$g_word" `txt-find.sh "$g_dirs"`
  fi
}

f_parse_args "$@"
f_print_args
f_check_args
f_run

