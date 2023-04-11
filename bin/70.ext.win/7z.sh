#!/bin/bash

export PATH="$SYS_PROG64_DIR/7-Zip:$PATH"

exec $WINPTY 7z.exe "$@"
