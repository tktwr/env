#!/bin/bash

f_user_name() {
  if [ -n "$USER" ]; then
    echo $USER
  elif [ -n "$USERNAME" ]; then
    echo $USERNAME
  else
    echo "unknown_user_name"
  fi
}

f_host_name() {
  if [ -n "$HOSTNAME" ]; then
    echo $HOSTNAME
  else
    echo "unknown_host_name"
  fi
}

f_os_name() {
  local os_name=$(uname -osr)
  case $os_name in
    *Msys*)
      if [[ $HOME =~ /c/Users ]]; then
        echo "gitbash"
      else
        echo "msys"
      fi
      ;;
    *WSL*)
      echo "wsl"
      ;;
    *Linux*)
      echo "linux"
      ;;
    *)
      echo "unknown_os_name"
      ;;
  esac
}

#------------------------------------------------------
f_sys_win_home() {
  local dir=$HOME/WinHome
  if [ -d "$dir" ]; then
    echo $(realpath "$dir")
  else
    echo $HOME
  fi
}

f_sys_local_home()   { echo $HOME; }
f_sys_roaming_home() { echo $(realpath "$HOME/MyRoaming"); }
f_sys_config_home()  { echo $(realpath "$HOME/MyConfig"); }
f_sys_work_home()    { echo $(realpath "$HOME/MyWork"); }
f_sys_proj_home()    { echo $(realpath "$HOME/MyProj"); }
f_sys_data_home()    { echo $(realpath "$HOME/MyData"); }

#------------------------------------------------------
f_min() {
  echo "export MY_USER_NAME=$(f_user_name)"
  echo "export MY_HOST_NAME=$(f_host_name)"
  echo "export MY_OS_NAME=$(f_os_name)"
  echo
  echo "export SYS_WIN_HOME=$(f_sys_win_home)"
  echo "export SYS_LOCAL_HOME=$(f_sys_local_home)"
  echo "export SYS_ROAMING_HOME=$(f_sys_roaming_home)"
  echo "export SYS_CONFIG_HOME=$(f_sys_config_home)"
  echo "export SYS_WORK_HOME=$(f_sys_work_home)"
  echo "export SYS_PROJ_HOME=$(f_sys_proj_home)"
  echo "export SYS_DATA_HOME=$(f_sys_data_home)"
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
