#!/bin/bash

f_pw_opt() {
  pw_opt='hidden,right,60%,border-left'
  if [ $COLUMNS -lt 120 ]; then
    pw_opt='hidden,down,60%,border-top'
  fi
  echo $pw_opt
}

#------------------------------------------------------
pw_opt=$(f_pw_opt)
files="$@"

FZF_DEFAULT_COMMAND="bmk.sh $files" \
fzf --prompt 'Bmk> ' \
    --ansi \
    --header '[A-oi] Open|Web, [A-/] Preview' \
    --bind 'alt-o:execute(open.sh $(bmk_get_value.sh {}))' \
    --bind 'alt-i:execute(open_web.sh $(bmk_get_value.sh {}))' \
    --preview 'preview_bmk.sh {}' \
    --preview-window "$pw_opt"
