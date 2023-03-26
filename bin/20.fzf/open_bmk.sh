#!/bin/bash

bmk_get_value() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++'
}

#------------------------------------------------------
line=$(echo "$*" | bmk_get_value)

case "$line" in
  '>'*)
    echo "tcmd: [$line]"
    ;;
  ':'*)
    echo "vcmd: [$line]"
    ;;
  '_Plug_'*)
    echo "vcmd: [$line]"
    ;;
  http*)
    echo "http: [$line]"
    chrome.sh "$line"
    ;;
  *)
    open.sh "$line"
    ;;
esac
