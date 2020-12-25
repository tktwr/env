#!/bin/bash

#======================================================
# windows
#======================================================

PATH="$JAVA_HOME/bin:$PATH"
PATH="$ANDROID_SDK/platform-tools:$PATH"
PATH="$NODEJS_HOME:$PATH"

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
# python venv
#------------------------------------------------------

export MY_PYTHON_EXE=python

mypython-venv-activate() {
  MY_OLD_PATH=$PATH
  PATH="$MY_PYTHON_VENV_DIR/$1:$PATH"
  PATH="$MY_PYTHON_VENV_DIR/$1/Scripts:$PATH"
  MY_PYTHON_VENV="$1"
}

mypython-venv-deactivate() {
  PATH=$MY_OLD_PATH
  MY_PYTHON_VENV=""
}

#------------------------------------------------------
# alias
#------------------------------------------------------

alias x='x.sh'
alias ls='ls.sh'

alias adb='winpty adb'
alias net='winpty net'
alias ping='winpty ping'
alias ipconfig='winpty ipconfig'
alias tracert='winpty tracert'

net-info() {
  net share
  net use
}
