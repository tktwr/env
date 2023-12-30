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
export PATH="$SYS_PROG64_DIR/Mozilla Firefox:$PATH"

url=$(eval "echo $*")  # expand env variables
wp=$(f_expand "$url")

exec $WINPTY firefox.exe "$wp" > /dev/null 2>&1 &
