#!/bin/bash

#------------------------------------------------------
f_os_name() {
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)  echo "msys" ;;
    *WSL*)   echo "wsl" ;;
    *Linux*) echo "linux" ;;
    *)       echo "unknown" ;;
  esac
}

f_host_name() {
  if [ -n "$HOSTNAME" ]; then
    echo $HOSTNAME
  else
    echo "unknown"
  fi
}

f_user_name() {
  if [ -n "$USER" ]; then
    echo $USER
  elif [ -n "$USERNAME" ]; then
    echo $USERNAME
  else
    echo "unknown"
  fi
}

f_shell_name() {
  echo "bash"
}

f_site_name() {
  echo "home"
}

f_home() {
  echo $HOME
}

f_pathconv() {
  pathconv.sh unix "$1"
  #pathconv.py -t unix -p /mnt "$1"
}

f_win_home() {
  echo $(f_pathconv "$HOME/WinHome")
}

f_prog32_dir() {
  echo $(f_pathconv 'C:\Program Files (x86)')
}

f_prog64_dir() {
  echo $(f_pathconv 'C:\Program Files')
}

f_user_prog_dir() {
  echo $(f_pathconv "$HOME/WinHome/AppData/Local/Programs")
}

f_default() {
  echo "export MY_OS_NAME=$(f_os_name)"
  echo "export MY_HOST_NAME=$(f_host_name)"
  echo "export MY_USER_NAME=$(f_user_name)"
  echo "export MY_SHELL_NAME=$(f_shell_name)"
  echo "export MY_SITE_NAME=$(f_site_name)"
  echo "export MY_HOME=$(f_home)"
  echo "export SYS_WIN_HOME=$(f_win_home)"
  echo "export SYS_PROG32_DIR=$(f_prog32_dir)"
  echo "export SYS_PROG64_DIR=$(f_prog64_dir)"
  echo "export USER_PROG_DIR=$(f_user_prog_dir)"
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
