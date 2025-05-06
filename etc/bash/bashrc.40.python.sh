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
  export PATH="$APP_L_MINIFORGE3/condabin:$PATH"
}
#------------------------------------------------------
_my_setup_python_linux() {
  export PYTHONPATH="$SYS_BLENDER_PY:$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
}

_my_setup_conda_linux() {
  __conda_setup="$('~/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "~/miniconda3/etc/profile.d/conda.sh" ]; then
          source "~/miniconda3/etc/profile.d/conda.sh"
      else
          export PATH="~/miniconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup
}
#------------------------------------------------------
my_setup_python() {
  case $MY_OS_NAME in
    msys|gitbash)
      MyCall "_my_setup_python_win"
      MyCall "_my_setup_conda_win"
      ;;
    *)
      MyCall "_my_setup_python_linux"
      MyCall "_my_setup_conda_linux"
      ;;
  esac
}

