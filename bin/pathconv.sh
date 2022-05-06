#!/bin/bash

f_path_unix() {
  local p="$1"
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)
      cygpath -au "$p"
      ;;
    *WSL*)
      if [ -e "$p" ]; then
        wslpath -au `wslpath -aw "$p"`
      else
        echo "$p"
      fi
      ;;
    *)
      echo "$p"
      ;;
  esac
}

f_path_win() {
  local p="$1"
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)
      cygpath -aw "$p"
      ;;
    *WSL*)
      wslpath -aw "$p"
      ;;
    *)
      echo "$p"
      ;;
  esac
}

os_name=$1
shift
f_path_$os_name "$*"
