#!/bin/bash

export PATH="$SYS_PROG32_DIR/Vim/vim81:$PATH"
export PATH="$SYS_PROG32_DIR/Vim/vim82:$PATH"
export PATH="$SYS_PROG64_DIR/Vim/vim90:$PATH"

vimrc=$(pathconv.sh win "$SYS_WIN_HOME/_vimrc")
wp=$(pathconv.sh win "$*")
exec $WINPTY gvim.exe -u "$vimrc" "$wp" > /dev/null 2>&1 &
