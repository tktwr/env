#!/bin/bash

source $HOME/.hostname

f_expand_dir() {
  local os="$1"
  local name="$2"
  local val="$3"

  if [ -x /usr/bin/cygpath ]; then
    if [ "$os" = "unix" ]; then
      dir=`cygpath -u "$val"`
    elif [ "$os" = "win" ]; then
      dir=`cygpath -m "$val"`
    fi
  else
    dir="$val"
  fi

  echo "export $name=\"$dir\""
}

f_set_env_vars() {
  local os="$1"

  if [ ! -z "$USERPROFILE" ]; then
    f_expand_dir $os SYS_PROG64_DIR "C:\Program Files"
    f_expand_dir $os SYS_PROG32_DIR "C:\Program Files (x86)"
    f_expand_dir $os SYS_WIN_HOME "$USERPROFILE"
    f_expand_dir $os SYS_MSYS2_HOME "C:/msys64/home/$USERNAME"
    f_expand_dir $os SYS_CYGWIN_HOME "C:/cygwin64/home/$USERNAME"
    f_expand_dir $os JAVA_HOME "C:\Program Files\Android\Android Studio\jre"
    f_expand_dir $os ANDROID_SDK "$USERPROFILE/AppData/Local/Android/sdk"
    f_expand_dir $os ANACONDA_HOME "$USERPROFILE/Anaconda3"
    f_expand_dir $os MINICONDA_HOME "$USERPROFILE/miniconda3"
    f_expand_dir $os MY_PYTHON_HOME "$USERPROFILE/AppData/Local/Programs/Python/Python38-32"
    f_expand_dir $os MY_PYTHON_ROAMING "$USERPROFILE/AppData/Roaming/Python/Python38"
    f_expand_dir $os MY_WIN_HOME "$USERPROFILE"
  else
    f_expand_dir $os SYS_WIN_HOME "$HOME/WinHome"
    f_expand_dir $os MY_WIN_HOME "$HOME/WinHome"
  fi
}

f_get_files() {
  local files="bashrc.??.*"

  for i in $files; do
    case $i in
      bashrc.[0-4]?.*)
        echo $i ;;
      bashrc.50.os.$MY_OS_NAME)
        echo $i ;;
      bashrc.51.shell.$MY_SHELL_NAME)
        echo $i ;;
      bashrc.52.site.$MY_SITE_NAME)
        echo $i ;;
      bashrc.53.host.$MY_HOST_NAME)
        echo $i ;;
      bashrc.[6-9]?.*)
        echo $i ;;
    esac
  done
}

f_make_bashrc() {
  local files=`f_get_files`
  local I
  for I in $files; do
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

f_make_local_bashrc() {
  local local_bashrc_dir=$MY_LOCAL_CONFIG/env/etc/bash
  local files="bashrc"
  local I
  for I in $files; do
    I=$local_bashrc_dir/$I
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

os=$1

f_set_env_vars $os
cat bashrc.time
f_make_bashrc
f_make_local_bashrc

