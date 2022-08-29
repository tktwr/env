#!/bin/bash

export PATH="$SYS_C/tools/neovim/Neovim/bin:$PATH"

exec $WINPTY nvim.exe "$@"
