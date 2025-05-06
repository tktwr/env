#!/bin/bash

#======================================================
# setup
#======================================================
# opencv's openexr feature is disabled in default for security issues
# the following env variable enable it
export OPENCV_IO_ENABLE_OPENEXR=1

MyCall "f_set_core_off"
MyCall "my_setup_os"
MyCall "my_setup_path"
MyCall "my_setup_vim"
MyCall "my_setup_fzf"
MyCall "my_setup_alias"
