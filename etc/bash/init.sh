#!/bin/bash

_MY_CONFIG=../../../..
_MY_REMOTE_FZY=$_MY_CONFIG/tktwr.github/env/etc/fzy
_MY_LOCAL_FZY=$_MY_CONFIG/tktwr.local/env/etc/fzy
_MY_PRIVATE_FZY=$_MY_CONFIG/tktwr.private/env/etc/fzy

if [ ! -z "$USERPROFILE" ]; then
  ./make-dir.py $_MY_REMOTE_FZY/dir.00.msys.txt
else
  ./make-dir.py $_MY_REMOTE_FZY/dir.00.unix.txt
fi

cat bashrc.env

DIRS="\
$_MY_REMOTE_FZY \
$_MY_LOCAL_FZY \
$_MY_PRIVATE_FZY \
~/.my \
"

for i in $DIRS; do
  ./make-dir.py $i/dir.01.usr.txt
done

for i in $DIRS; do
  ./make-dir.py $i/dir.txt
done

