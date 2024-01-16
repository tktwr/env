#!/bin/bash

#======================================================
# setup
#======================================================
# opencv's openexr feature is disabled in default for security issues
# the following env variable enable it
export OPENCV_IO_ENABLE_OPENEXR=1

f_set_core_off

my_setup_os
my_setup_path
my_setup_vim
my_setup_fzf
my_setup_alias

