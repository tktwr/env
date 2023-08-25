#!/bin/bash

pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

if [ $MY_OS_NAME = 'gitbash' ]; then
  pw_opt='hidden'
fi

files="$@"

FZF_DEFAULT_COMMAND="bmk.sh $files" \
fzf --prompt 'Bmk> ' \
    --ansi \
    --header '[A-O:open|A-T:preview|A-N:p-next|A-P:p-prev]' \
    --bind 'alt-o:execute(open_bmk.sh {})' \
    --preview 'preview_bmk.sh {}' \
    --preview-window "$pw_opt"
