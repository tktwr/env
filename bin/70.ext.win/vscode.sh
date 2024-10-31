#!/bin/bash

export PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
export PATH="$APP_L_PROG/Microsoft VS Code:$PATH"

wp=$(_f_expand_win "$*")

exec $WINPTY Code.exe "$wp" > /dev/null 2>&1 &
