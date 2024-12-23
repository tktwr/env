#!/bin/bash

f_git_wsl() {
  if _in_win_dir; then
    #echo "[git.exe]" 1>&2
    /mnt/c/Program\ Files/Git/cmd/git.exe "$@"
  else
    #echo "[/usr/bin/git]" 1>&2
    /usr/bin/git "$@"
  fi
}

os_name=$(uname -osr)
case $os_name in
  *WSL*)
    f_git_wsl "$@"
    ;;
  *)
    git "$@"
    ;;
esac
