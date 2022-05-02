#!/bin/bash

#BIN_FILE="explorer.exe"
BIN_FILE="$MY_PUBLIC/bin/te210114/TE64.exe"

f_check_exe() {
  if [ "$1" = "explorer.exe" ]; then
    return
  fi
  if [ ! -x "$1" ]; then
    echo "no exe: $1"
    exit
  fi
}

f_winpath() {
  local wp="$@"

  if [ -z "$wp" -o "$wp" = "." ]; then
    wp=$(pwd)
  fi

  echo $(cygpath -w $wp)
}

f_check_exe "$BIN_FILE"
wp=$(f_winpath "$@")

exec "$BIN_FILE" "$wp" > /dev/null 2>&1 &

