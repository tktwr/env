#!/bin/bash

pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

files="$@"

FZF_DEFAULT_COMMAND="bmk.sh $files" \
fzf --prompt 'Bmk> ' \
    --ansi \
    --header '[A-o] Open, [A-t] Preview' \
    --bind 'alt-o:execute(open_bmk.sh {})' \
    --preview 'preview_bmk.sh {}' \
    --preview-window "$pw_opt"
