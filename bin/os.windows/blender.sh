#!/bin/bash

export PATH="\
$SYS_PROG64_DIR/Blender Foundation/Blender 2.83:\
$SYS_PROG64_DIR/Blender Foundation/Blender:\
$PATH"
BIN_FILE="blender.exe"

#if [ ! -x "$BIN_FILE" ]; then
#  echo "no $BIN_FILE"
#  exit
#fi

exec winpty "$BIN_FILE" "$@"

