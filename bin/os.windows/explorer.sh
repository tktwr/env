#!/bin/sh

winpath=""

if [ ! -z "$1" ]; then
  winpath=`cygpath -w $1`
fi

explorer.exe $winpath

