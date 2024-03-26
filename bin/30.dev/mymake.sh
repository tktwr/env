#!/bin/bash

f_make() {
  if [ -x "make.sh" ]; then
    ./make.sh "$@"
  elif [ -x "_make.sh" ]; then
    ./_make.sh "$@"
  elif [ -f "Makefile" ]; then
    make --no-print-directory "$@"
  fi
}

f_make "$@"
