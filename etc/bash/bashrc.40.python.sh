#!/bin/bash

#======================================================
# python
#======================================================

#------------------------------------------------------
# python venv
#------------------------------------------------------
mypython-venv-info() {
  mypython.sh --list-venv
}

mypython-venv-create() {
  mypython.sh --create-venv $1
  source $HOME/.bashrc
}

mypython-venv-exist() {
  venv_name=${1:-"default"}
  venv_dir=$MY_PYTHON_VENV_DIR/$venv_name
  return $(test -d $venv_dir)
}

mypython-venv-activate() {
  venv_name=${1:-"default"}
  venv_dir=$MY_PYTHON_VENV_DIR/$venv_name
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
# select python
#------------------------------------------------------

mypython-path() {
  case $MY_OS_NAME in
    msys|gitbash)
      export MY_PYTHON_EXE="python"
      export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
      export PYTHONPATH="$MY_SAMPLES_WIN/py/lib;$PYTHONPATH"
      export PYTHONPATH="$SYS_BLENDER_PY_WIN;$PYTHONPATH"
      ;;
    *)
      export MY_PYTHON_EXE="python3"
      export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
      export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
      export PYTHONPATH="$SYS_BLENDER_PY:$PYTHONPATH"
      ;;
  esac
}

mypython-type() {
  local python_type=$1

  case $python_type in
    python-win)
      PATH="$USER_PYTHON_ROAMING:$PATH"
      PATH="$USER_PYTHON_ROAMING/Scripts:$PATH"
      PATH="$USER_PYTHON_HOME:$PATH"
      PATH="$USER_PYTHON_HOME/Scripts:$PATH"
      alias pip='winpty pip'
      alias python='winpty python'
      ;;
    python)
      ;;
  esac
}

#------------------------------------------------------
# mypython.sh
#------------------------------------------------------
mypython-set-python-win() {
  mypython.sh --set python-win $1
  source_bashrc
}

mypython-set-python() {
  mypython.sh --set python $1
  source_bashrc
}

