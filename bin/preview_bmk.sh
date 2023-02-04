#!/bin/bash

bmk_get_value() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++'
}

bmk_rm_tcmd() {
  sed -e 's+> ++' -e 's+<CR>++'
}

f_preview() {
  file=$(eval "echo $1")
  if [ -f "$file" ]; then
    batcat -n --color=always "$file"
  else
    echo "$file"
  fi
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
    f_preview "$file"
    ;;
esac
