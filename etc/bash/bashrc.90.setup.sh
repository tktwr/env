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

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
f_ins_path  $MY_VIM_PLUGGED_DIR/fzf/bin
source_file $MY_VIM_PLUGGED_DIR/fzf/shell/completion.bash
source_file $MY_VIM_PLUGGED_DIR/fzf/shell/key-bindings.bash

source_file $MY_VIM_PLUGGED_DIR/vim-ide-style/etc/bashrc
source_file $MY_VIM_PLUGGED_DIR/vim-ide-style/etc/bashrc.alias
source_file $MY_VIM_PLUGGED_DIR/vim-memo/etc/bashrc

if [ "$VIM_TERMINAL" ]; then
  vimapi-tabline-set-info "[ :$MY_PYTHON_TYPE,$MY_PYTHON_VENV][ :$MY_BUILD_SYS,$MY_BUILD_CONFIG]"
  vimapi-term-set-label "$MY_USER_NAME@$MY_HOST_NAME [$MY_OS_NAME]"
fi

