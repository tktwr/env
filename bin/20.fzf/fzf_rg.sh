#!/bin/bash

query="${1:-}"
query="-w $query"
shift
dirs="$@"

RG_PREFIX="rg.sh"
FZF_DEFAULT_COMMAND="$RG_PREFIX $query $dirs" \
fzf --prompt 'Rg> ' \
    --query "$query" \
    --ansi \
    --disabled \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $dirs || true" \
    --delimiter ':' \
    --header '[A-oi] Open|Web, [A-/] Preview' \
    --bind 'alt-o:execute(open.sh {1})' \
    --bind 'alt-i:execute(open_web.sh {1})' \
    --preview 'preview_rg.sh {1} {2}' \
    --preview-window "$(f_fzf_pw_opt)"
