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
  local target_os="$1"

  if [ ! -z "$USERPROFILE" ]; then
    f_expand_dir $target_os SYS_PROG64_DIR "C:\Program Files"
    f_expand_dir $target_os SYS_PROG32_DIR "C:\Program Files (x86)"

    f_expand_dir $target_os SYS_WIN_HOME "$USERPROFILE"
    f_expand_dir $target_os SYS_MSYS2_HOME "C:/msys64/home/$USERNAME"
    f_expand_dir $target_os SYS_CYGWIN_HOME "C:/cygwin64/home/$USERNAME"

    f_expand_dir $target_os USER_PROG_DIR "$USERPROFILE/AppData/Local/Programs"
    f_expand_dir $target_os USER_PYTHON_HOME "$USERPROFILE/AppData/Local/Programs/Python/Python38-32"
    f_expand_dir $target_os USER_PYTHON_ROAMING "$USERPROFILE/AppData/Roaming/Python/Python38"

    f_expand_dir $target_os JAVA_HOME "C:\Program Files\Android\Android Studio\jre"
    f_expand_dir $target_os ANDROID_SDK "$USERPROFILE/AppData/Local/Android/sdk"
    f_expand_dir $target_os ANACONDA_HOME "$USERPROFILE/Anaconda3"
    f_expand_dir $target_os MINICONDA_HOME "$USERPROFILE/miniconda3"
  else
    f_expand_dir $target_os SYS_WIN_HOME "$HOME/WinHome"
  fi

  if [ -d $SYS_WIN_HOME ]; then
    f_expand_dir $target_os MY_HOME "$SYS_WIN_HOME"
  else
    f_expand_dir $target_os MY_HOME "$HOME"
  fi

  echo 'source $HOME/.hostname'

  if [ ! -z "$USERPROFILE" ]; then
    f_expand_dir win MY_LIBTT_WIN $MY_LIBTT
    f_expand_dir win MY_OPT_WIN $MY_OPT
    f_expand_dir win MY_DATA_WIN $MY_DATA
    #f_expand_dir $target_os XDG_CONFIG_HOME $SYS_WIN_HOME/.config
  #else
    #f_expand_dir $target_os XDG_CONFIG_HOME $HOME/.config
  fi
}

f_get_bashrc() {
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

f_cat_bashrc() {
  local DIR=$1
  shift
  local files="$@"
  local I
  for I in $files; do
    I=$DIR/$I
    if [ -f $I ]; then
      echo "f_time_start $I"
      cat $I
      echo "f_time_end $I"
    fi
  done
}

cat bashrc.time
f_set_env_vars $1
f_cat_bashrc . `f_get_bashrc`
f_cat_bashrc $MY_LOCAL_CONFIG/env/etc/bash bashrc

