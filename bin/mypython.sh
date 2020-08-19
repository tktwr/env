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
  echo "  --set MY_PYTHON_TYPE MY_PYTHON_VENV    set envs"
  echo "  --python-type                          print MY_PYTHON_TYPE"
  echo "  --python-venv                          print MY_PYTHON_VENV"
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

f_set() {
  echo "export MY_PYTHON_TYPE=$1"
  echo "export MY_PYTHON_VENV=$2"
}

case $1 in
  --help)
    f_help
    ;;
  --set)
    shift
    f_set "$@" > $PYTHONRC
    ;;
  --python-type)
    echo $MY_PYTHON_TYPE
    ;;
  --python-venv)
    echo $MY_PYTHON_VENV
    ;;
esac

