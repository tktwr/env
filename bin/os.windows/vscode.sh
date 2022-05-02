#!/bin/bash

export SYS_PROG64_DIR="/c/Program Files"
export USER_PROG_DIR="/c/Users/$USER/AppData/Local/Programs"

export PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
export PATH="$USER_PROG_DIR/Microsoft VS Code:$PATH"

exec Code.exe "$@" > /dev/null 2>&1 &

