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

f_win_path() {
  local l_winpath="$@"

  if [ -z "$l_winpath" -o "$l_winpath" = "." ]; then
    l_winpath=$(pwd)
  fi

  l_winpath=$(cygpath -w $l_winpath)
  echo $l_winpath
}

f_check_exe "$BIN_FILE"
winpath=$(f_win_path "$@")

exec "$BIN_FILE" "$winpath" > /dev/null 2>&1 &

