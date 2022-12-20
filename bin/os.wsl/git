#!/bin/bash

in_win_dir() {
  rp=$(realpath "$PWD")
  case $rp in
    /mnt/*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

if in_win_dir; then
  /mnt/c/Program\ Files/Git/cmd/git.exe "$@"
else
  /usr/bin/git "$@"
fi
