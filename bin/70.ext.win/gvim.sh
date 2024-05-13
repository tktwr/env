#!/bin/bash

export PATH="$SYS_PROG32_DIR/Vim/vim81:$PATH"
export PATH="$SYS_PROG32_DIR/Vim/vim82:$PATH"
export PATH="$SYS_PROG64_DIR/Vim/vim90:$PATH"

wp=$(_f_expand_win "$*")
vimrc=$(_f_expand_win "$SYS_WIN_HOME/_vimrc")

if [ -n "$wp" ]; then
  exec $WINPTY gvim.exe -u "$vimrc" "$wp" > /dev/null 2>&1 &
else
  exec $WINPTY gvim.exe -u "$vimrc" > /dev/null 2>&1 &
fi
