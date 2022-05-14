#!/bin/bash

export PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
export PATH="$USER_PROG_DIR/Microsoft VS Code:$PATH"

exec $WINPTY Code.exe "$@" > /dev/null 2>&1 &
