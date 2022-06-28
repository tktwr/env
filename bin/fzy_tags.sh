#!/bin/bash

get_tags() {
  tags="tags*"
  topdir=$(git rev-parse --show-toplevel 2> /dev/null)
  if [ -n "$topdir" ]; then
    tags="$topdir/tags*"
  fi
  echo $tags
}

#------------------------------------------------------
fzy_pre() {
  grep -v '!_TAG_'
}

fzy_post() {
  awk '{print $1}'
}

fzy_tags() {
  tags=$(get_tags)
  if [ -f "$tags" ]; then
    cmd="cat $tags"
    p=$(eval $cmd | fzy_pre | fzy | fzy_post)
    echo $p
  fi
}

#------------------------------------------------------
fzy_tags "$@"

