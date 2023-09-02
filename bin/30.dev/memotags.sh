#!/bin/bash

# f_memotags 'word' files
f_memotags() {
  echo '!_TAG_FILE_ENCODING	utf-8	//'
  word=$1
  shift
  for i in "$@"; do
    tags=`grep "*$word" $i | sed -n "s/.*\*\($word.*\)\*.*/\1/p"`
    for j in $tags; do
      echo "$j	$i	/*$j*/;\"	f"
    done
  done
}

f_memotags "$@" | sort
