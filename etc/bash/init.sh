#!/bin/bash

if [ ! -z "$USERPROFILE" ]; then
  ./make-dir.py ../fzy/dir.sys.msys.txt
else
  ./make-dir.py ../fzy/dir.sys.unix.txt
fi

cat bashrc.env

./make-dir.py ../fzy/dir.txt

