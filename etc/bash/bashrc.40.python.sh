#!/bin/bash

#======================================================
# python
#======================================================

mypython-venv-info() {
  ls $MY_PYTHON_VENV_DIR
}

mypython-venv-create() {
  if [ -z "$1" ]; then
    echo "mypython-venv-create venv_name"
    return
  fi

  mypython-venv-exist $1
  if [ $? -eq 0 ]; then
    echo "already existed: $1"
    return
  fi

  $MY_PYTHON_EXE -m venv $MY_PYTHON_VENV_DIR/$1
  mypython.sh --set $MY_PYTHON_TYPE $1
  source $HOME/.bashrc
}

mypython-venv-exist() {
  return $(test -d $MY_PYTHON_VENV_DIR/$1)
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

