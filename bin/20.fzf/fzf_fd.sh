#!/bin/bash

dirs="$@"
export FZF_DEFAULT_COMMAND="fd.sh a $dirs"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS $(f_fzf_pw_opt)"
fzf --prompt 'Fd> ' \
    --ansi \
    --header '[A-adf] All|Dir|File, [A-oi] Open|Web, [A-/] Preview' \
    --bind "alt-a:reload(fd.sh a $dirs)" \
    --bind "alt-d:reload(fd.sh d $dirs)" \
    --bind "alt-f:reload(fd.sh f $dirs)" \
    --bind 'alt-o:execute(open.sh {})' \
    --bind 'alt-i:execute(open_web.sh {})' \
    --preview 'preview.sh {}'
