#!/bin/bash

export PATH="$SYS_PROG32_DIR/Google/Chrome/Application:$PATH"
export PATH="$SYS_PROG64_DIR/Google/Chrome/Application:$PATH"

wp=$(_f_expand_win "$*")

exec $WINPTY chrome.exe "$wp" > /dev/null 2>&1 &
