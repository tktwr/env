#!/bin/bash

#======================================================
# python
#======================================================
_my_setup_python_win() {
  export PYTHONPATH="$SYS_BLENDER_PY_WIN;$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES_WIN/py/lib;$PYTHONPATH"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export PATH="$APP_R_PYTHON:$PATH"
  export PATH="$APP_R_PYTHON/Scripts:$PATH"
  export PATH="$APP_L_PYTHON:$PATH"
  export PATH="$APP_L_PYTHON/Scripts:$PATH"

  alias pip='winpty pip'
  alias python='winpty python'
}

_my_setup_conda_win() {
  export PATH="$APP_L_MINIFORGE3_WIN/condabin:$PATH"
}

_my_setup_python_linux() {
  export PYTHONPATH="$SYS_BLENDER_PY:$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
}

my_setup_python() {
  case $MY_OS_NAME in
    msys|gitbash)
      _my_setup_python_win
      _my_setup_conda_win
      ;;
    *)
      _my_setup_python_linux
      ;;
  esac
}

