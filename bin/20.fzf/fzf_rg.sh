#!/bin/bash

query="${1:-}"
query="-w $query"
shift
dirs="$@"

RG_PREFIX="rg.sh"
FZF_DEFAULT_COMMAND="$RG_PREFIX $query $dirs" \
fzf --prompt 'Rg> ' \
    --ansi \
    --disabled \
    --query "$query" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $dirs || true" \
    --delimiter : \
    --preview 'preview_rg.sh {1} {2}' \
    --preview-window 'hidden,up,60%,+{2}/3'
