#!/bin/bash

f_to_unix() {
  local prefix=''
  local os_name=$(uname -osr)
  case $os_name in
    *WSL*|*Linux*)
      local prefix='/mnt'
      ;;
  esac
  sed -e 's+[\]+/+g' -e "s+^\([c-zC-Z]\):+$prefix/\L\1+"
}

f_path_unix() {
  local p=$(echo "$1" | f_to_unix)
  local p=$(realpath "$p")
  echo "$p"
}

f_path_win() {
  local p=$(echo "$1" | f_to_unix)
  local p=$(realpath "$p")
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
