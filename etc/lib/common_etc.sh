#!/bin/bash

echoerr() {
  echo "$@" 1>&2
}

f_source_file() {
  local l_file=$1
  if [ -f $l_file ]; then
    source $l_file
  else
    echoerr "no file: $l_file"
  fi
}

f_cygpath() {
  local opt="$1"
  local val="$2"
  local dir=""
  if [ -x /usr/bin/cygpath ]; then
    dir=`cygpath $opt "$val"`
  else
    dir="$val"
  fi
  echo "$dir"
}

f_set_min_env() {
  if [ -n "$USERPROFILE" ]; then
    export MY_HOME=$(f_cygpath "-u" $USERPROFILE)
    export MY_PYTHON_EXE="python"
    export MY_OS_NAME="windows"
  else
    export MY_HOME=$(f_cygpath "-u" $HOME)
    export MY_PYTHON_EXE="python3"
    export MY_OS_NAME="linux"
  fi

  export USER_PYTHON_HOME="$MY_HOME/AppData/Local/Programs/Python/Python38"
  export MY_CONFIG="$MY_HOME/MyConfig"
  export MY_REMOTE_CONFIG="$MY_CONFIG/tktwr.github"
  export MY_LOCAL_CONFIG="$MY_CONFIG/tktwr.local"
  export MY_PRIVATE_CONFIG="$MY_CONFIG/tktwr.private"

  if [ -z "$SYS_PATH" ]; then
    export SYS_PATH=$PATH
  fi
  export PATH="$SYS_PATH"

  export PATH="$USER_PYTHON_HOME:$PATH"

  echoerr "======================================================="
  echoerr "MY_HOME=$MY_HOME"
  echoerr "MY_CONFIG=$MY_CONFIG"
  echoerr "MY_REMOTE_CONFIG=$MY_REMOTE_CONFIG"
  echoerr "MY_LOCAL_CONFIG=$MY_LOCAL_CONFIG"
  echoerr "MY_PRIVATE_CONFIG=$MY_PRIVATE_CONFIG"
  echoerr "MY_OS_NAME=$MY_OS_NAME"
  echoerr "MY_PYTHON_EXE=$MY_PYTHON_EXE"
  echoerr "$(which $MY_PYTHON_EXE)"
  echoerr "-------------------------------------------------------"
}

if [ -n "$MY_LOADED_COMMON_ETC" ]; then
  echoerr "common_etc.sh: already loaded"
  return
fi
export MY_LOADED_COMMON_ETC=1

f_set_min_env

