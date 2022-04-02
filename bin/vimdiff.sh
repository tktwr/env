#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi.sh "call MyTabDiff('$1', '$2')"
else
  vimdiff "$1" "$2"
fi
