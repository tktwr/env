#!/bin/bash

fzy_arg_find_dir() {
  depth=${1:-3}
  echo $(find-dir.sh -maxdepth $depth | fzy)
}

fzy_arg_find_dir "$@"
