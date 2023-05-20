#!/bin/bash

if $(has_bin fdfind); then
fd_all()  { fdfind --color=always . "$@"; }
fd_dir()  { fdfind --color=always . "$@" --type=d; }
fd_file() { fdfind --color=always . "$@" --type=f; }
else
fd_all()  { find "$@"; }
fd_dir()  { find "$@" -type d; }
fd_file() { find "$@" -type f; }
fi

export -f fd_all
export -f fd_dir
export -f fd_file

#------------------------------------------------------
pw_opt=''
if [ $COLUMNS -lt 120 ]; then
  pw_opt='hidden'
fi

dirs="$@"

FZF_DEFAULT_COMMAND="fd_all $dirs" \
fzf --prompt 'Fd> ' \
    --ansi \
    --header '[A-A:all, A-E:dir, A-F:file, A-X:explorer, A-C:chrome, A-V:vscode, A-T:preview, A-N:p-next, A-P:p-prev]' \
    --bind "alt-a:reload(fd_all  $dirs)" \
    --bind "alt-e:reload(fd_dir  $dirs)" \
    --bind "alt-f:reload(fd_file $dirs)" \
    --bind 'alt-x:execute(te.sh {})' \
    --bind 'alt-c:execute(chrome.sh {})' \
    --bind 'alt-v:execute(vscode.sh {})' \
    --preview 'preview.sh {}' \
    --preview-window "$pw_opt"
