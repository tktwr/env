#!/bin/bash

#======================================================
# python
#======================================================
_my_setup_python_win() {
  export MY_PYTHON_EXE="python"
  export PYTHONPATH="$SYS_BLENDER_PY_WIN;$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES_WIN/py/lib;$PYTHONPATH"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export PATH="$USER_PYTHON_ROAMING:$PATH"
  export PATH="$USER_PYTHON_ROAMING/Scripts:$PATH"
  export PATH="$USER_PYTHON_HOME:$PATH"
  export PATH="$USER_PYTHON_HOME/Scripts:$PATH"

  alias pip='winpty pip'
  alias python='winpty python'
}

_my_setup_python_linux() {
  export MY_PYTHON_EXE="python3"
  export PYTHONPATH="$SYS_BLENDER_PY:$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
}

my_setup_python() {
  case $MY_OS_NAME in
    msys|gitbash)
      _my_setup_python_win
      ;;
    *)
      _my_setup_python_linux
      ;;
  esac
}

#------------------------------------------------------
# venv
#------------------------------------------------------
venv-create() {
  local dir=$HOME/.venv
  if [ ! -d "$dir" ]; then
    echo "$MY_PYTHON_EXE -m venv $dir"
    $MY_PYTHON_EXE -m venv $dir
  fi
}

venv-activate() {
  local dir=$HOME/.venv

  if [ ! -d "$dir" ]; then
    return
  fi

  case $MY_OS_NAME in
    msys|gitbash)
      MY_OLD_PATH=$PATH
      PATH="$dir:$PATH"
      PATH="$dir/Scripts:$PATH"
      ;;
    *)
      source $dir/bin/activate
      ;;
  esac
}

venv-deactivate() {
  case $MY_OS_NAME in
    msys|gitbash)
      PATH=$MY_OLD_PATH
      ;;
    *)
      deactivate
      ;;
  esac
}

