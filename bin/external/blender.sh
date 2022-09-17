#!/bin/bash

export PATH="$SYS_PROG64_DIR/Blender Foundation/Blender 3.3:$PATH"
export WSLENV=MY_DATA_WIN

exec $WINPTY blender.exe "$@"
