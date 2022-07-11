#!/bin/bash

export PATH="$SYS_PROG64_DIR/Blender Foundation/Blender 3.2:$PATH"

exec $WINPTY blender.exe "$@"
