#!/bin/bash

export PATH="$SYS_BLENDER:$PATH"

exec $WINPTY blender.exe "$@"
