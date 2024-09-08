#!/bin/bash

if [ -d "$1" ]; then
  echo "$1: skip: already existed"
  exit
fi

dst_dir=$(wslpath -aw "$1")
src_dir=$(wslpath -aw "$2")

# make a junction on NTFS
$WINPTY cmd.exe /c mklink /j "$dst_dir" "$src_dir"
