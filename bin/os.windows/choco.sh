#!/bin/sh

BIN_FILE=`cygpath -u $ALLUSERSPROFILE/chocolatey/choco.exe`

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

exec "$BIN_FILE" "$@"

