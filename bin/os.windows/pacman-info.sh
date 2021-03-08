#!/bin/bash

f_eval() {
  echo "=================================================="
  echo "$1"
  echo "=================================================="
  eval "$1"
}

f_eval "pacman -Sg"

f_eval "pacman -Sg base-devel"
f_eval "pacman -Sg mingw-w64-x86_64-toolchain"
f_eval "pacman -Sg mingw-w64-cross-toolchain"
f_eval "pacman -Sg mingw-w64-cross-clang-toolchain"

#f_eval "pacman -Si mingw-w64-x86_64-make"
