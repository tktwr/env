#!/bin/bash

fdfind_a() { fdfind --color=always . "$@"; }
fdfind_d() { fdfind --color=always . "$@" --type=d; }
fdfind_f() { fdfind --color=always . "$@" --type=f; }
find_a()   { find "$@" \( -type d \( -name '.git' -o -name 'build*' -o -name '__pycache__' \) -prune \) -o -print; }
find_d()   { find "$@" \( -type d \( -name '.git' -o -name 'build*' -o -name '__pycache__' \) -prune \) -o -type d; }
find_f()   { find "$@" \( -type d \( -name '.git' -o -name 'build*' -o -name '__pycache__' \) -prune \) -o -type f; }

fd_type=$1
shift
${SYS_FIND_EXE}_${fd_type} "$@"
