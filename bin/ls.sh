#!/bin/bash

exec /bin/ls -v -F --color=auto -I '{*}' -I 'NTUSER.*' -I 'ntuser.*' -I '*.lnk' -I '*.url' -I 'desktop.ini' "$@"

