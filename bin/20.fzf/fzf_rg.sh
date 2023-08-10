#!/bin/bash

query="${1:-}"
query="-w $query"
shift
dirs="$@"

RG_PREFIX="rg.sh"
FZF_DEFAULT_COMMAND="$RG_PREFIX $query $dirs" \
fzf --prompt 'Rg> ' \
    --ansi --info 'inline-right' \
    --disabled \
    --query "$query" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $dirs || true" \
    --delimiter : \
    --preview 'batcat -n --color=always {1} --highlight-line {2}' \
    --preview-window 'hidden,up,60%,+{2}/3'
