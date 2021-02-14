#!/bin/bash

if [ $# -ne 1 ]; then
  echo "$0 exe-file"
  exit
fi

files=`ldd $1 | grep -v '/c/WINDOWS' | sort -u | awk '{print $3}'`

if [ "x$files" != "x" ]; then
  cp $files .
fi

