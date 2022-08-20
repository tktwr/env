#!/bin/bash

export PATH="$SYS_PROG32_DIR/Vim/vim81:$PATH"
export PATH="$SYS_PROG32_DIR/Vim/vim82:$PATH"

vimrc=$(pathconv.sh win "$HOME/_vimrc")
wp=$(pathconv.sh win "$*")
exec $WINPTY vim.exe -u "$vimrc" "$wp"
