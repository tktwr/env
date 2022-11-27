#!/bin/bash

#======================================================
# python
#======================================================
#------------------------------------------------------
# type
#------------------------------------------------------
mypython-win() {
  export MY_PYTHON_EXE="python"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES_WIN/py/lib;$PYTHONPATH"
  export PYTHONPATH="$SYS_BLENDER_PY_WIN;$PYTHONPATH"
  export PATH="$USER_PYTHON_ROAMING:$PATH"
  export PATH="$USER_PYTHON_ROAMING/Scripts:$PATH"
  export PATH="$USER_PYTHON_HOME:$PATH"
  export PATH="$USER_PYTHON_HOME/Scripts:$PATH"
  alias pip='winpty pip'
  alias python='winpty python'
}

mypython-linux() {
  export MY_PYTHON_EXE="python3"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
  export PYTHONPATH="$SYS_BLENDER_PY:$PYTHONPATH"
}

mypython-type() {
  local python_type=$1

  case $python_type in
    python-win)
      mypython-win
      ;;
    python)
      mypython-linux
      ;;
  esac
}

#------------------------------------------------------
# venv
#------------------------------------------------------
mypython-venv-info() {
  mypython.sh --list-venv
}

mypython-venv-create() {
  local venv_name=${1:-"default"}
  mypython.sh --create-venv $venv_name
  source_bashrc
}

mypython-venv-activate() {
  local venv_name=${1:-"default"}
  local venv_dir=$MY_PYTHON_VENV_DIR/$venv_name

  if [ ! -d "$venv_dir" ]; then
    return
  fi

  case $MY_OS_NAME in
    msys|gitbash)
      MY_OLD_PATH=$PATH
      PATH="$venv_dir:$PATH"
      PATH="$venv_dir/Scripts:$PATH"
      ;;
    *)
      source $venv_dir/bin/activate
      ;;
  esac
  MY_PYTHON_VENV="$venv_name"
}

mypython-venv-deactivate() {
  case $MY_OS_NAME in
    msys|gitbash)
      PATH=$MY_OLD_PATH
      ;;
    *)
      deactivate
      ;;
  esac
  MY_PYTHON_VENV=""
}

#------------------------------------------------------
# mypython.sh
#------------------------------------------------------
mypython-set() {
  local python_type=${1:-"python"}
  local venv_name=${2:-"default"}

  mypython.sh --set $python_type $venv_name
  source_bashrc
}

