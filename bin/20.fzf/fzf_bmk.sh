#!/bin/bash

files="$@"

pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

BMK_PREFIX="bmk.sh"
FZF_DEFAULT_COMMAND="$BMK_PREFIX $files" \
fzf --prompt 'Bmk> ' \
    --ansi \
    --header '[A-O:open, A-T:preview, A-N:p-next, A-P:p-prev]' \
    --bind 'alt-o:execute(open_bmk.sh {})' \
    --preview 'preview_bmk.sh {}' \
    --preview-window "$pw_opt"
