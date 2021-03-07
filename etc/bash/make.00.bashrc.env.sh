#!/bin/bash

source ../lib/common_etc.sh

DIRS="\
$MY_REMOTE_CONFIG/env/etc/fzy \
$MY_LOCAL_CONFIG/env/etc/fzy \
$MY_PRIVATE_CONFIG/env/etc/fzy \
$MY_HOME/.my.common \
"

f_proc() {
  local l_file="$1"
  if [ -f "$l_file" ]; then
    echoerr "processing... $l_file"
    $MY_PYTHON_EXE ./make.dir.py "$l_file"
  fi
}

for i in $DIRS; do
  f_proc $i/dir.00.$MY_OS_NAME.txt
done

for i in $DIRS; do
  f_proc $i/dir.01.usr.txt
done

for i in $DIRS; do
  f_proc $i/dir.txt
done

