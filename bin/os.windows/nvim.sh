#!/bin/bash

BIN_FILE=`cygpath -u C:/tools/neovim/Neovim/bin/nvim.exe`

if [ ! -x "$BIN_FILE" ]; then
  echo "no $BIN_FILE"
  exit
fi

exec winpty "$BIN_FILE" "$@"

