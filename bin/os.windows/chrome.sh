#!/bin/bash

export SYS_PROG32_DIR="/c/Program Files (x86)"
export PATH="$SYS_PROG32_DIR/Google/Chrome/Application:$PATH"

exec chrome.exe "$@" > /dev/null 2>&1 &

