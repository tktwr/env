#!/bin/bash

#======================================================
# setup
#======================================================

# opencv's openexr feature is disabled in default for security issues
# the following env variable enable it
export OPENCV_IO_ENABLE_OPENEXR=1

mypython-type $MY_PYTHON_TYPE
mypython-venv-activate $MY_PYTHON_VENV

f_set_core_off
f_set_prompt

my_setup_vim
my_setup_path_os
