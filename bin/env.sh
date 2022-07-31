#!/bin/bash

f_user_name() {
  if [ -n "$USER" ]; then
    echo $USER
  elif [ -n "$USERNAME" ]; then
    echo $USERNAME
  else
    echo "unknown"
  fi
}

f_host_name() {
  if [ -n "$HOSTNAME" ]; then
    echo $HOSTNAME
  else
    echo "unknown"
  fi
}

f_os_name() {
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)
      if [[ $HOME =~ /home ]]; then
        echo "msys"
      else
        echo "gitbash"
      fi
      ;;
    *WSL*)
      echo "wsl"
      ;;
    *Linux*)
      echo "linux"
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

#------------------------------------------------------
f_sys_config_home() {
  local os_name=$(f_os_name)
  case $os_name in
    msys)
      echo $(pathconv.sh unix "$HOME/WinHome")
      ;;
    *)
      echo $HOME
      ;;
  esac
}

f_my_config() {
  echo $(pathconv.sh unix "$HOME/MyConfig")
}

f_my_share() {
  echo $(pathconv.sh unix "$HOME/MyShare")
}

#------------------------------------------------------
f_sys_win_home() {
  if [ -d "$HOME/WinHome" ]; then
    echo $(pathconv.sh unix "$HOME/WinHome")
  else
    echo $HOME
  fi
}

f_user_prog_dir() {
  local win_home=$(f_sys_win_home)
  echo $(pathconv.sh unix "$win_home/AppData/Local/Programs")
}

f_prog32_dir() {
  echo $(pathconv.sh unix 'C:\Program Files (x86)')
}

f_prog64_dir() {
  echo $(pathconv.sh unix 'C:\Program Files')
}

#------------------------------------------------------
f_cc() {
  echo "clang"
}

f_cxx() {
  echo "clang++"
}

#------------------------------------------------------
f_min() {
  echo "export MY_USER_NAME=$(f_user_name)"
  echo "export MY_HOST_NAME=$(f_host_name)"
  echo "export MY_OS_NAME=$(f_os_name)"
  echo
  echo "export CC=$(f_cc)"
  echo "export CXX=$(f_cxx)"
  echo
  echo "export SYS_WIN_HOME=$(f_sys_win_home)"
  echo "export SYS_CONFIG_HOME=$(f_sys_config_home)"
}

f_dir() {
  echo "export MY_CONFIG=$(f_my_config)"
  echo "export MY_SHARE=$(f_my_share)"
  echo "export USER_PROG_DIR=$(f_user_prog_dir)"
  echo "export SYS_PROG32_DIR=$(f_prog32_dir)"
  echo "export SYS_PROG64_DIR=$(f_prog64_dir)"
}

f_all() {
  f_min
  f_dir
}

f_default() {
  f_min
}

#======================================================
# main
#======================================================
func_name=${1:-"default"}
shift
eval "f_$func_name $@"
