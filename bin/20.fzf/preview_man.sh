#!/bin/bash

f_preview() {
  man $(echo "$*" | awk '{print $2,$1}' | sed 's/[()]//g') | batcat -l=man -p --color=always
}

f_preview "$*"
