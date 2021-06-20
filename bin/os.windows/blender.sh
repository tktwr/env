#!/bin/bash

export PATH="\
$SYS_PROG64_DIR/Blender Foundation/Blender 2.92:\
$SYS_PROG64_DIR/Blender Foundation/Blender 2.83:\
$SYS_PROG64_DIR/Blender Foundation/Blender:\
$PATH"

BIN_FILE="blender.exe"

exec winpty "$BIN_FILE" "$@"

