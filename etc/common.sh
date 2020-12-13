#!/bin/bash

echoerr() {
  echo "$@" 1>&2
}

f_source_file() {
  file=$1
  if [ -f $file ]; then
    source $file
  else
    echoerr "no file: $file"
    exit
  fi
}

f_cygpath() {
  local opt="$1"
  local val="$2"
  if [ -x /usr/bin/cygpath ]; then
    dir=`cygpath $opt "$val"`
  else
    dir="$val"
  fi
  echo "$dir"
}

