#!/bin/bash

f_prefix() {
  local prefix=''
  local os_name=$(uname -osr)
  case $os_name in
    *WSL*|*Linux*)
      local prefix='/mnt'
      ;;
  esac
  echo $prefix
}

f_to_unix() {
  local prefix=$(f_prefix)
  sed -e 's+[\]+/+g' -e "s+^\([c-zC-Z]\):+$prefix/\L\1+"
}

f_to_win() {
  local prefix=$(f_prefix)
  local wslhome="$(wslpath -am /home)"
  sed -e "s+$prefix/\([c-zC-Z]\)+\U\1:+" -e "s+^/home+$wslhome+" -e 's+/+\\+g'
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
      if [ -f "$p" ]; then
        wslpath -aw "$p"
      else
        echo "$p" | f_to_win
      fi
      ;;
    *)
      echo "$p"
      ;;
  esac
}

os_name=$1
shift
pth="$*"
if [ -n "$pth" ]; then
  f_path_$os_name "$pth"
fi
