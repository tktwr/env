#!/bin/bash

export PATH="$SYS_PROG32_DIR/Google/Chrome/Application:$PATH"
export PATH="$SYS_PROG64_DIR/Google/Chrome/Application:$PATH"

url="$*"

if [[ "$url" =~ 'http' ]]; then
  wp="$url"
else
  wp=$(pathconv.sh win "$url")
fi

exec $WINPTY chrome.exe "$wp" > /dev/null 2>&1 &
