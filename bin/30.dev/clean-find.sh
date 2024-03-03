#!/bin/bash

bin_name=`basename $0`

opt=''

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [option] [action]"
  echo
  echo "OPTIONS"
  echo "  -h, --help       ... print help"
  echo "  --pycache-dir    ... print pycache dirs"
  echo "  --build-dir      ... print build dirs"
  echo "  --doxygen-dir    ... print doxygen dirs"
  echo "  --output-dir     ... print output dirs"
  echo "  --blender-backup ... print blender backup files"
  echo
  echo "ACTIONS"
  echo "  -rm              ... remove found dirs/files"
}

f_clean() {
  echo "--- [find . $opt] ----------"
  eval "find . $opt"
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        exit
        ;;
      --pycache-dir)
        opt="$opt -type d -name '__pycache__' -prune"
        ;;
      --build-dir)
        opt="$opt -type d -name '_build*' -prune"
        ;;
      --doxygen-dir)
        opt="$opt -type d -name '_doxygen*' -prune"
        ;;
      --output-dir)
        opt="$opt -type d -name '_output*' -prune"
        ;;
      --blender-backup)
        opt="$opt -type f -name '*.blend1'"
        ;;
      -rm)
        opt="$opt -print -exec rm -rf {} +"
        ;;
    esac
  done
}

f_args "$@"
f_clean
