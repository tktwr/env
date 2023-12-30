#!/bin/bash

export PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
export PATH="$USER_PROG_DIR/Microsoft VS Code:$PATH"

url=$(eval "echo $*")  # expand env variables
wp=$(pathconv.sh win "$url")
exec $WINPTY Code.exe "$wp" > /dev/null 2>&1 &
