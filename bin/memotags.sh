#!/bin/bash

files=$*

echo "!_TAG_FILE_ENCODING	utf-8	//"

f_memotags() {
  for i in $*; do
    tags=`grep '*memo_' $i | sed -n 's/.*\*\(memo_.*\)\*.*/\1/p'`
    for j in $tags; do
      echo "$j	$i	/*$j*"
    done
  done
}

f_memotags $files | sort

