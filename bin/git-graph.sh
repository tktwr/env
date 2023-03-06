#!/bin/bash

# less options:
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init

$GIT_EXE graph "$@" | less -EFRSX
