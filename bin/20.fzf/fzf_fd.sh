#!/bin/bash

dirs="$@"

pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

FD_PREFIX="fdfind"
FZF_DEFAULT_COMMAND="$FD_PREFIX . $dirs" \
fzf --prompt 'Fd> ' \
    --header '[A-A:all, A-D:dir, A-F:file, A-X:explorer, A-C:chrome, A-V:vscode, A-T:preview, A-N:p-next, A-P:p-prev]' \
    --bind "alt-a:reload($FD_PREFIX . $dirs)" \
    --bind "alt-d:reload($FD_PREFIX . $dirs --type=d)" \
    --bind "alt-f:reload($FD_PREFIX . $dirs --type=f)" \
    --bind 'alt-x:execute(te.sh {})' \
    --bind 'alt-c:execute(chrome.sh {})' \
    --bind 'alt-v:execute(vscode.sh {})' \
    --preview 'preview.sh {}' \
    --preview-window "$pw_opt"
