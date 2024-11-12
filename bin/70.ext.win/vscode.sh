#!/bin/bash

dir="${*:-$PWD}"

if _in_win_dir; then
  export PATH="$SYS_PROG64_DIR/Microsoft VS Code:$PATH"
  export PATH="$APP_L_PROG/Microsoft VS Code:$PATH"

  wp=$(_f_expand_win "$dir")

  exec $WINPTY Code.exe "$wp" > /dev/null 2>&1 &
else
  exec code "$dir" > /dev/null 2>&1 &
fi
