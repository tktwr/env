#!/bin/bash

export PATH="$SYS_PROG64_DIR/Mozilla Firefox:$PATH"

wp=$(_f_expand_win "$*")

exec $WINPTY firefox.exe "$wp" > /dev/null 2>&1 &
