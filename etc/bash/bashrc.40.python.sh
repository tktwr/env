#!/bin/bash

#======================================================
# python
#======================================================

if [ -n "$USERPROFILE" ]; then
  # msys2/gitbash
  export MY_PYTHON_EXE="python"
  export PYTHONPATH="$MY_BIN_WIN/py;$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES_WIN/py/lib;$PYTHONPATH"
else
  # linux/android
  export MY_PYTHON_EXE="python3"
  export PYTHONPATH="$MY_BIN/py:$PYTHONPATH"
  export PYTHONPATH="$MY_SAMPLES/py/lib:$PYTHONPATH"
fi

#------------------------------------------------------
# python venv
#------------------------------------------------------
mypython-venv-info() {
  ls $MY_PYTHON_VENV_DIR
}

mypython-venv-create() {
  venv_name=$1
  if [ -z "$venv_name" ]; then
    echo "mypython-venv-create venv_name"
    return
  fi

  mypython-venv-exist $venv_name
  if [ $? -eq 0 ]; then
    echo "already existed: $venv_name"
    return
  fi

  $MY_PYTHON_EXE -m venv $MY_PYTHON_VENV_DIR/$venv_name
  mypython.sh --set $MY_PYTHON_TYPE $venv_name
  source $HOME/.bashrc
}

mypython-venv-exist() {
  venv_name=$1
  return $(test -d $MY_PYTHON_VENV_DIR/$venv_name)
}

mypython-venv-activate() {
  venv_name=$1
  if [ -n "$USERPROFILE" ]; then
    MY_OLD_PATH=$PATH
    PATH="$MY_PYTHON_VENV_DIR/$venv_name:$PATH"
    PATH="$MY_PYTHON_VENV_DIR/$venv_name/Scripts:$PATH"
  else
    source $MY_PYTHON_VENV_DIR/$venv_name/bin/activate
  fi
  MY_PYTHON_VENV="$venv_name"
}

mypython-venv-deactivate() {
  if [ -n "$USERPROFILE" ]; then
    PATH=$MY_OLD_PATH
  else
    deactivate
  fi
  MY_PYTHON_VENV=""
}

#------------------------------------------------------
# anaconda
#------------------------------------------------------

f_set_python_anaconda() {
  PATH="$ANACONDA_HOME:$PATH"
  PATH="$ANACONDA_HOME/Scripts:$PATH"
}

#------------------------------------------------------
# miniconda
#------------------------------------------------------

f_set_python_miniconda() {
  #PATH="$MINICONDA_HOME:$PATH"
  #PATH="$MINICONDA_HOME/Scripts:$PATH"
  #source $MINICONDA_HOME/etc/profile.d/conda.sh

  eval "$($MINICONDA_HOME/Scripts/conda.exe 'shell.bash' 'hook')"
  #export CONDA_ENVS_PATH=$HOME/.conda/envs
  #export CONDA_PKGS_DIRS=$HOME/.conda/pkgs
  #conda activate base
}

#------------------------------------------------------
# python
#------------------------------------------------------

f_set_python_win() {
  PATH="$USER_PYTHON_ROAMING:$PATH"
  PATH="$USER_PYTHON_ROAMING/Scripts:$PATH"
  PATH="$USER_PYTHON_HOME:$PATH"
  PATH="$USER_PYTHON_HOME/Scripts:$PATH"
}

#------------------------------------------------------
# select python
#------------------------------------------------------

f_select_python() {
  local python_type=$1

  case $python_type in
    python-anaconda)
      f_set_python_anaconda
      ;;
    python-miniconda)
      f_set_python_miniconda
      ;;
    python-win)
      f_set_python_win
      ;;
    python)
      ;;
  esac

  case $python_type in
    python-anaconda|python-miniconda|python-win)
      alias pip='winpty pip'
      alias python='winpty python'
      alias ipython='winpty ipython'
      alias jupyter='winpty jupyter'
      ;;
    python)
      ;;
  esac
}

f_activate_python() {
  local python_type=$1
  local python_venv=$2

  if [ ! -z "$python_venv" ]; then
    case $python_type in
      python-anaconda|python-miniconda)
        conda activate $python_venv
        ;;
      python-win|python)
        mypython-venv-activate $python_venv
        ;;
    esac
  fi
}

