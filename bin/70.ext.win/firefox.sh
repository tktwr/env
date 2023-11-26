#!/bin/bash

export PATH="$SYS_PROG64_DIR/Mozilla Firefox:$PATH"

url="$*"

if [[ "$url" =~ 'http' ]]; then
  wp="$url"
else
  wp=$(pathconv.sh win "$url")
fi

exec $WINPTY firefox.exe "$wp" > /dev/null 2>&1 &
