#!/bin/bash

winpath=""

if [ ! -z "$1" ]; then
  winpath=`cygpath -w $1`
fi

explorer.exe $winpath

