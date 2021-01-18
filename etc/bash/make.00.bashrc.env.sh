#!/bin/bash

if [ ! -z "$USERPROFILE" ]; then
  export PATH=$HOME/AppData/Local/Programs/Python/Python38:$PATH
  export MY_PYTHON_EXE=python
else
  export MY_PYTHON_EXE=python3
fi

_MY_CONFIG=../../../..
_MY_REMOTE_FZY=$_MY_CONFIG/tktwr.github/env/etc/fzy
_MY_LOCAL_FZY=$_MY_CONFIG/tktwr.local/env/etc/fzy
_MY_PRIVATE_FZY=$_MY_CONFIG/tktwr.private/env/etc/fzy

DIRS="\
$_MY_REMOTE_FZY \
$_MY_LOCAL_FZY \
$_MY_PRIVATE_FZY \
$HOME/.my \
"

if [ ! -z "$USERPROFILE" ]; then
  $MY_PYTHON_EXE ./make.dir.py $_MY_REMOTE_FZY/dir.00.msys.txt
else
  $MY_PYTHON_EXE ./make.dir.py $_MY_REMOTE_FZY/dir.00.unix.txt
fi

for i in $DIRS; do
  $MY_PYTHON_EXE ./make.dir.py $i/dir.01.usr.txt
done

for i in $DIRS; do
  $MY_PYTHON_EXE ./make.dir.py $i/dir.txt
done

