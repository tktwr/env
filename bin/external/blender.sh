#!/bin/bash

export PATH="$SYS_PROG64_DIR/Blender Foundation/Blender 3.1:$PATH"

exec $WINPTY blender.exe "$@"
