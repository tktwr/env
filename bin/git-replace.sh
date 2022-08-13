#!/bin/sh

bin_name=`basename $0`

f_help() {
  echo "NAME"
  echo "  $bin_name - replace words for tracked files in git"
  echo
  echo "SYNOPSIS"
	echo "  $bin_name src_word dst_word"
  echo
  echo "OPTIONS"
  echo "  -h, --help ... print this help"
  echo
  echo "NOTE"
  echo "  '|' can not be included in src_word."
}

f_replace() {
  src="$1"
  dst="$2"

  files=`git-grep.sh -l "$src"`
  for i in $files; do
    echo "$i"
    sed -i "s|$src|$dst|g" $i
  done
}

if [ $# -eq 2 ]; then
  f_replace "$1" "$2"
else
  f_help
fi
