#!/bin/bash

fzy_make_post() {
  awk '{print $1}'
}

fzy_make() {
  cmd="mymake.sh help"
  echo $(eval $cmd | fzy | fzy_make_post)
}

#------------------------------------------------------
fzy_make "$@"

