#!/bin/bash

url=$(_f_expand "$*")

case "$url" in
  http*)
    open_web.sh "$url"
    ;;
  *.pdf)
    open_pdf.sh "$url"
    ;;
  *)
    url=$(pathconv.sh unix "$url")
    if [ -d "$url" ]; then
      open_dir.sh "$url"
    elif [ -f "$url" ]; then
      open_file.sh "$url"
    fi
    ;;
esac
