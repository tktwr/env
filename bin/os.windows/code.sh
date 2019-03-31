#!/bin/sh

BIN_FILE="$SYS_PROG64_DIR/Microsoft VS Code/Code.exe"

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

exec "$BIN_FILE" "$@"

