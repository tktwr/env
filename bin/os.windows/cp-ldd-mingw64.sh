#!/bin/sh

if [ $# -ne 1 ]; then
  echo "$0 exe-file"
  exit
fi

files=`ldd $1 | grep mingw64 | sort -u | awk '{print $3}'`

if [ "x$files" != "x" ]; then
  cp $files .
fi

