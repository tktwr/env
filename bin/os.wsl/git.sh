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
  echo "[git.exe]" 1>&2
  /mnt/c/Program\ Files/Git/cmd/git.exe "$@"
else
  echo "[/usr/bin/git]" 1>&2
  /usr/bin/git "$@"
fi
