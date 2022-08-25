#!/bin/bash

export PATH="/c/tools/neovim/Neovim/bin:$PATH"

exec $WINPTY nvim.exe "$@"
