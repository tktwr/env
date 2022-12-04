#!/bin/bash

#------------------------------------------------------
fzy_find_post() {
  awk '{print $1}'
}

fzy_find() {
  depth=${1:-6}
  cmd="find-dir.sh -maxdepth $depth"

  p=$(eval $cmd | fzy | fzy_find_post)
  if [ -n "$p" ]; then
    p=$(pathconv.sh unix "$p")
  fi
  echo $p
}

#------------------------------------------------------
fzy_find "$@"
