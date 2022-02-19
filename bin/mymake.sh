#!/bin/bash

mymake() {
  if [ -f "Makefile" ]; then
    make --no-print-directory "$@"
  elif [ -x "make.sh" ]; then
    ./make.sh "$@"
  fi
}

mymake "$@"
