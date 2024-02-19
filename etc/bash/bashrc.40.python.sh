#!/bin/bash

#======================================================
# python
#======================================================
_my_setup_python_win() {
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

