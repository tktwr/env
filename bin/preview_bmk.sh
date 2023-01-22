#!/bin/bash

bmk_get_value() {
  awk -F '|' '{print $2}' | sed -e 's+^ *++' -e 's+> ++' -e 's+<CR>++'
}

file=$(echo "$*" | bmk_get_value)
file=$(eval "echo $file")

if [ -f "$file" ]; then
  batcat -n --color=always "$file"
else
  echo "$file"
fi
