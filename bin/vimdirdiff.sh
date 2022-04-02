#!/bin/bash

if [ "$VIM_TERMINAL" ]; then
  vimapi.sh "call MyTabDirDiff('$1', '$2')"
else
  vim -c "call MyDirDiff('$1', '$2')"
fi
