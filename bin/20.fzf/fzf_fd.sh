#!/bin/bash

pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

dirs="$@"

FZF_DEFAULT_COMMAND="fd.sh a $dirs" \
fzf --prompt 'Fd> ' \
    --ansi \
    --header '[A-A:all|A-D:dir|A-F:file|A-X:explorer|A-C:chrome|A-V:vscode|A-T:preview|A-N:p-next|A-P:p-prev]' \
    --bind "alt-a:reload(fd.sh a $dirs)" \
    --bind "alt-d:reload(fd.sh d $dirs)" \
    --bind "alt-f:reload(fd.sh f $dirs)" \
    --bind 'alt-x:execute(te.sh {})' \
    --bind 'alt-c:execute(chrome.sh {})' \
    --bind 'alt-v:execute(vscode.sh {})' \
    --preview 'preview.sh {}' \
    --preview-window "$pw_opt"
