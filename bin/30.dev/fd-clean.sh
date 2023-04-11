#!/bin/bash

bin_name=`basename $0`

opt=''

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help       ... print help"
  echo "  --pycache-dir    ... find pycache dirs"
  echo "  --build-dir      ... find build dirs"
  echo "  --output-dir     ... find output dirs"
  echo "  --doxygen-dir    ... find doxygen dirs"
  echo "  --svn-dir        ... find svn dirs"
  echo "  --blender-backup ... find blender backup files"
  echo "  -rm              ... remove found dirs/files"
}

f_clean() {
  eval "fdfind $opt"
}

f_args() {
  for i in "$@"; do
    case "$i" in
      -h|--help)
        f_help
        exit
        ;;
      --pycache-dir)
        opt="$opt -I -t d --prune -g '__pycache__'"
        ;;
      --build-dir)
        opt="$opt -I -t d --prune -g 'build*'"
        ;;
      --output-dir)
        opt="$opt -I -t d --prune -g '_output*'"
        ;;
      --doxygen-dir)
        opt="$opt -I -t d --prune -g 'doxygen'"
        ;;
      --git-dir)
        opt="$opt -IH -t d --prune -g '.git'"
        ;;
      --svn-dir)
        opt="$opt -IH -t d --prune -g '.svn'"
        ;;
      --blender-backup)
        opt="$opt -I -t f -e 'blend1'"
        ;;
      -rm)
        opt="$opt -X rm -rf {}"
        ;;
      -du)
        opt="$opt -X du -hs {}"
        ;;
    esac
  done
}

f_args "$@"
f_clean
