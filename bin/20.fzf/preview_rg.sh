#!/bin/bash

#f_batcat() { batcat -n --color=always $1 --highlight-line $2; }
f_batcat() { batcat -n --color=always $1 --highlight-line $2 --line-range $2:; }
f_cat()    { cat $1; }

f_$SYS_CAT_EXE "$@"
