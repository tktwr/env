#!/bin/bash

export PATH="\
$SYS_PROG64_DIR/Blender Foundation/Blender 3.0:\
$SYS_PROG64_DIR/Blender Foundation/Blender 2.93:\
$PATH"

BIN_FILE="blender.exe"

exec winpty "$BIN_FILE" "$@"

