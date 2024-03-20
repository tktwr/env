#!/bin/bash

query="${1:-}"
query="-w $query"
shift
dirs="$@"

export FZF_DEFAULT_COMMAND="rg.sh $query $dirs"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $(f_fzf_pw_opt)"
fzf --prompt 'Rg> ' \
    --query "$query" \
    --ansi \
    --disabled \
    --bind "change:reload:sleep 0.1; rg.sh {q} $dirs || true" \
    --delimiter ':' \
    --header '[A-oi] Open|Web, [A-/] Preview' \
    --bind 'alt-o:execute(open.sh {1})' \
    --bind 'alt-i:execute(open_web.sh {1})' \
    --preview 'preview_rg.sh {1} {2}'
