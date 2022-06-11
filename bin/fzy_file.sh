#!/bin/bash

fzy_arg_find_file() {
  depth=${1:-3}
  echo $(find-txt.sh -maxdepth $depth | fzy)
}

fzy_arg_find_file "$@"
