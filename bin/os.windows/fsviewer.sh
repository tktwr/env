#!/bin/bash

BIN_FILE="$SYS_PROG32_DIR/FastStone Image Viewer/fsviewer.exe"

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

exec "$BIN_FILE" "$@"

