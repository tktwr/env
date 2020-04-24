#!/bin/bash

BIN_FILE="$SYS_PROG32_DIR/Google/Chrome/Application/chrome.exe"

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

exec "$BIN_FILE" "$@"

