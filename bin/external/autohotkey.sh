#!/bin/bash

export PATH="$SYS_PROG64_DIR/AutoHotkey:$PATH"

exec $WINPTY AutoHotkey.exe "$@"
