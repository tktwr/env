#!/bin/bash

#======================================================
# android
#======================================================

#------------------------------------------------------
# python venv
#------------------------------------------------------

export MY_PYTHON_EXE=python3

mypython-venv-activate() {
  source $MY_PYTHON_VENV_DIR/$1/bin/activate
  MY_PYTHON_VENV="$1"
}

mypython-venv-deactivate() {
  deactivate
  MY_PYTHON_VENV=""
}

#------------------------------------------------------

alias ls='ls -F'

