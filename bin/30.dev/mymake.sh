#!/bin/bash

mymake() {
  if [ -x "make.sh" ]; then
    ./make.sh "$@"
  elif [ -f "Makefile" ]; then
    make --no-print-directory "$@"
  fi
}

mymake "$@"
