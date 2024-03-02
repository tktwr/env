#!/bin/bash

#------------------------------------------------------
f_has_bin() {
  which $1 > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo true
  else
    echo false
  fi
}

f_sys_exe() {
  for i in "$@"; do
    if $(f_has_bin $i); then
      echo $i
      return
    fi
  done
  echo "NONE"
}

#------------------------------------------------------
f_user_name() {
  if [ -n "$USER" ]; then
    echo $USER
  elif [ -n "$USERNAME" ]; then
    echo $USERNAME
  else
    #echo "unknown_user_name"
    echo $(whoami)
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
    *Android*)
      echo "termux"
      ;;
    *Linux*)
      echo "linux"
      ;;
    *)
      echo "unknown_os_name"
      ;;
  esac
}

f_my_python_exe() {
  os_name=$(f_os_name)
  case $os_name in
    gitbash)
      echo "python"
      ;;
    *)
      echo "python3"
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
f_all() {
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
  echo
  echo "export SYS_CAT_EXE=$(f_sys_exe batcat cat)"
  echo "export SYS_FIND_EXE=$(f_sys_exe fdfind find)"
  echo "export SYS_FZF_EXE=$(f_sys_exe fzf)"
  echo "export MY_PYTHON_EXE=$(f_my_python_exe)"
}

#------------------------------------------------------
f_symlink() {
  if [ ! -e "$2" -a ! -L "$2" ]; then
    echo "ln -s $1 $2"
    ln -s $1 $2
  fi
}

f_zero_dir() {
  cd
  os_name=$(f_os_name)
  case $os_name in
    wsl)
      f_symlink WinHome/MyConfig MyConfig
      f_symlink WinHome/MyData   MyData
      f_symlink WinHome/MyProj   MyProj
      f_symlink WinHome/MyWork   MyWork
      ;;
  esac

  mkdir -p $HOME/.my
  mkdir -p $HOME/.mycache
}

#======================================================
# main
#======================================================
f_zero_dir
f_all > $HOME/.my/hostname.sh
