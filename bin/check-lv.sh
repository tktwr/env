#!/bin/sh

which lv > /dev/null 2>&1
if [ $? -eq 0 ]; then
  export PAGER='lv -c -Ou8'
fi

