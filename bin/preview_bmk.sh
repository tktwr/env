#!/bin/bash

bmk_get_value() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++'
}

bmk_rm_tcmd() {
  sed -e 's+> ++' -e 's+<CR>++'
}

#------------------------------------------------------
file=$(echo "$*" | bmk_get_value)

case "$file" in
  '>'*)
    echo "tcmd: [$file]"
    ;;
  ':'*)
    echo "vcmd: [$file]"
    ;;
  '_Plug_'*)
    echo "vcmd: [$file]"
    ;;
  http*)
    echo "http: [$file]"
    ;;
  *)
    preview.sh "$file"
    ;;
esac
