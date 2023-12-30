#!/bin/bash

# expand env variables
url=$(eval "echo $*")

case "$url" in
  http*)
    open_web.sh "$url"
    ;;
  *.pdf)
    open_web.sh "$url"
    ;;
  *)
    if [ -d "$url" ]; then
      open_dir.sh "$url"
    elif [ -f "$url" ]; then
      open_file.sh "$url"
    fi
    ;;
esac
