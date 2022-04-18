#!/bin/bash

PYTHONRC=$HOME/.my/pythonrc

if [ -f $PYTHONRC ]; then
  source $PYTHONRC
fi

f_help() {
  echo "mypython.sh [OPTIONS]"
  echo
  echo "OPTIONS:"
  echo "  --help                                 print help"
  echo "  --set MY_PYTHON_TYPE MY_PYTHON_VENV    set env vars"
  echo "  --python-type                          print MY_PYTHON_TYPE"
  echo "  --python-venv                          print MY_PYTHON_VENV"
  echo "  --list-venv                            list venv"
  echo "  --create-venv venv_name                create venv"
  echo
  echo "PYTHON_TYPE:"
  echo "  python-anaconda"
  echo "  python-miniconda"
  echo "  python-win"
  echo "  python"
  echo
  echo "ENVS:"
  echo "  MY_PYTHON_TYPE=$MY_PYTHON_TYPE"
  echo "  MY_PYTHON_VENV=$MY_PYTHON_VENV"
}

f_print_export() {
  echo "export MY_PYTHON_TYPE=$1"
  echo "export MY_PYTHON_VENV=$2"
}

f_set() {
  f_print_export $1 $2 > $PYTHONRC
}

f_venv_list() {
  ls $MY_PYTHON_VENV_DIR
}

f_venv_exist() {
  local venv_name=$1
  return $(test -d $MY_PYTHON_VENV_DIR/$venv_name)
}

f_venv_create() {
  local venv_name=$1
  if [ -z "$venv_name" ]; then
    echo "mypython.sh: f_venv_create venv_name"
    return
  fi

  f_venv_exist $venv_name
  if [ $? -eq 0 ]; then
    echo "mypython.sh: venv is already existed: $venv_name"
    return
  fi

  $MY_PYTHON_EXE -m venv $MY_PYTHON_VENV_DIR/$venv_name
  f_set $MY_PYTHON_TYPE $venv_name
}

case $1 in
  --help)
    f_help
    ;;
  --set)
    shift
    f_set $1 $2
    ;;
  --python-type)
    echo $MY_PYTHON_TYPE
    ;;
  --python-venv)
    echo $MY_PYTHON_VENV
    ;;
  --list-venv)
    f_venv_list
    ;;
  --create-venv)
    shift
    f_venv_create $1
    ;;
esac

