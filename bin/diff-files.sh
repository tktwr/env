#!/bin/bash

bin_name=`basename $0`

DIFF_CMD=cmp
DST_DIR=$HOME
FILES=""

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options] files"
  echo
  echo "OPTIONS"
  echo "  -h, --help     ... print help"
  echo "  -c, --cmd      ... set diff command [cmp|diff|vimdiff]"
  echo "  -d, --dst      ... set dst dir [default=$HOME]"
}

#------------------------------------------------------
# f_diff file1 file2
#------------------------------------------------------
f_diff() {
  if [ ! -f "$1" ]; then
    echo "[no file] $1"
  fi
  if [ ! -f "$2" ]; then
    echo "[no file] $2"
  fi
  if [ ! \( -f "$1" -a -f "$2" \) ]; then
    return
  fi
  cmp -s "$1" "$2"
  if [ $? -eq 0 ]; then
    echo "[==] $1 $2"
  elif [ $? -eq 1 ]; then
    echo "[!=] $1 $2"
    if [ "$DIFF_CMD" = "diff" -o "$DIFF_CMD" = "vimdiff" ]; then
      eval "$DIFF_CMD $1 $2"
    fi
  fi
}

#------------------------------------------------------
# f_diff_files
#------------------------------------------------------
f_diff_files() {
  for i in $FILES; do
    f_diff $i $DST_DIR/$i
  done
}

#------------------------------------------------------
# f_args args
#------------------------------------------------------
f_args() {
  while [ $# -gt 0 ]; do
    case "$1" in
      -h|--help)
        f_help
        exit
        ;;
      -c|--cmd)
        shift
        DIFF_CMD=$1
        ;;
      -d|--dst)
        shift
        DST_DIR=$1
        ;;
      *)
        FILES="$FILES $1"
        ;;
    esac
    shift
  done
}

f_args "$@"
f_diff_files

