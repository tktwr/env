#!/bin/bash

bmk_get_value() {
  awk -F '|' '{print $3}' | sed -e 's+^ *++'
}

val=$(echo "$*" | bmk_get_value)
echo $val
