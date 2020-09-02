#!/bin/bash

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name"
  echo
  echo "SYNOPSIS"
  echo "  $bin_name [options]"
  echo
  echo "OPTIONS"
  echo "  -h, --help        print help"
  echo "  -p, --print-no-x  print no x mode files"
  echo "  -x, --add-x       add x mode"
}

git-get-no-x() {
  git ls-files -s | grep '^100644' | awk '{print $4}'
}

git-chmod-x-all() {
  files=`git-get-no-x`
  git update-index --add --chmod=+x $files
}

case $1 in
  -h|--help)
    f_help
    exit
    ;;
  -p|--print-no-x)
    git-get-no-x
    ;;
  -x|--add-x)
    git-chmod-x-all
    ;;
esac

