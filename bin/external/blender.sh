#!/bin/bash

export PATH="$SYS_PROG64_DIR/Blender Foundation/Blender 3.3:$PATH"

exec $WINPTY blender.exe "$@"
