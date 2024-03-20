#!/bin/bash

files="$@"
export FZF_DEFAULT_COMMAND="bmk.sh $files"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $(f_fzf_pw_opt)"
fzf --prompt 'Bmk> ' \
    --ansi \
    --header '[A-oi] Open|Web, [A-/] Preview' \
    --bind 'alt-o:execute(open.sh $(bmk_get_value.sh {}))' \
    --bind 'alt-i:execute(open_web.sh $(bmk_get_value.sh {}))' \
    --preview 'preview_bmk.sh {}'
