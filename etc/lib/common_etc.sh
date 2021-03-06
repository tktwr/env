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

f_set_python() {
  if [ ! -z "$USERPROFILE" ]; then
    export PATH=$HOME/AppData/Local/Programs/Python/Python38:$PATH
    export PATH=$HOME/WinHome/AppData/Local/Programs/Python/Python38:$PATH
    export MY_PYTHON_EXE=python
  else
    export MY_PYTHON_EXE=python3
  fi
}

f_set_python

