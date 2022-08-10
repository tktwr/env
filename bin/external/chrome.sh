#!/bin/bash

export PATH="$SYS_PROG32_DIR/Google/Chrome/Application:$PATH"
export PATH="$SYS_PROG64_DIR/Google/Chrome/Application:$PATH"

exec $WINPTY chrome.exe "$@" > /dev/null 2>&1 &
