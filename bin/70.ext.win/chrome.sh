#!/bin/bash

f_expand() {
  url="$1"
  if [[ "$url" =~ 'http' ]]; then
    echo "$url"
  else
    echo $(pathconv.sh win "$url")
  fi
}

#------------------------------------------------------
export PATH="$SYS_PROG32_DIR/Google/Chrome/Application:$PATH"
export PATH="$SYS_PROG64_DIR/Google/Chrome/Application:$PATH"

url=$(eval "echo $*")  # expand env variables
wp=$(f_expand "$url")

exec $WINPTY chrome.exe "$wp" > /dev/null 2>&1 &
