#!/bin/bash

PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
PATH="$USER_PROG_DIR/Microsoft VS Code:$PATH"

exec Code.exe "$@" > /dev/null 2>&1 &

