#!/bin/bash

INITIAL_QUERY="${1:-}"
shift
dirs="$@"

RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case --"
FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY") $dirs" \
fzf --prompt 'rg> ' \
    --ansi \
    --disabled \
    --query "$INITIAL_QUERY" \
    --bind "change:reload:sleep 0.1; $RG_PREFIX {q} $dirs || true" \
    --delimiter : \
    --preview 'batcat -n --color=always {1} --highlight-line {2}' \
    --preview-window 'hidden,up,60%,+{2}/3'
