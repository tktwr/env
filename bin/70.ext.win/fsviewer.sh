#!/bin/bash

export PATH="$SYS_PROG32_DIR/FastStone Image Viewer:$PATH"

exec $WINPTY fsviewer.exe "$@" > /dev/null 2>&1 &
