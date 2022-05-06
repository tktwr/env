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
  local p="$1"
  local p=$(echo $p | f_to_unix)
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)
      cygpath -au "$p"
      ;;
    *WSL*)
      if [ -e "$p" ]; then
        local pw=$(wslpath -aw "$p")
        wslpath -au "$pw"
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
  local p=$(echo $p | f_to_unix)
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
