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
dirs="$@"

FZF_DEFAULT_COMMAND="fd.sh a $dirs" \
fzf --prompt 'Fd> ' \
    --ansi \
    --header '[A-adf] All|Dir|File, [A-oi] Open|Web, [A-/] Preview' \
    --bind "alt-a:reload(fd.sh a $dirs)" \
    --bind "alt-d:reload(fd.sh d $dirs)" \
    --bind "alt-f:reload(fd.sh f $dirs)" \
    --bind 'alt-o:execute(open.sh {})' \
    --bind 'alt-i:execute(open_web.sh {})' \
    --preview 'preview.sh {}' \
    --preview-window "$pw_opt"
