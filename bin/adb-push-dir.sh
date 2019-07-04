#!/bin/sh

f_make_dir() {
  local src=$1
  local dst=$2
  local dirs=`find $src -type d -name '.git' -prune -o -type d -print`

  for i in $dirs; do
    eval "adb shell mkdir -p $dst/$i"
  done
}

f_cp_files() {
  local src=$1
  local dst=$2
  local files=`find $src -type d -name '.git' -prune -o -type f -print`

  for i in $files; do
    eval "adb push $i $dst/$i"
  done
}

f_make_dir $1 $2
f_cp_files $1 $2

