#!/bin/bash

#======================================================
# setup
#======================================================

f_set_core_off

mypython-type $MY_PYTHON_TYPE
mypython-venv-activate $MY_PYTHON_VENV

if [ $MY_PROMPT_TYPE -ge 3 ]; then
  f_set_prompt_git
elif [ $MY_PROMPT_TYPE -ge 2 ]; then
  f_set_prompt_git_fast
  alias g.='f_checkgit_force'
elif [ $MY_PROMPT_TYPE -ge 1 ]; then
  f_set_prompt_minimal
  alias g.='f_set_prompt_minimal'
else
  f_set_prompt_none
fi

# opencv's openexr feature is disabled in default for security issues
# the following env variable enable it
export OPENCV_IO_ENABLE_OPENEXR=1

#------------------------------------------------------
# vim plugin
#------------------------------------------------------
source $MY_VIM/plugged/vim-ide-style/etc/bashrc
source $MY_VIM/plugged/vim-ide-style/etc/bashrc.alias
source $MY_VIM/plugged/vim-memo/etc/bashrc

if [ "$VIM_TERMINAL" ]; then
  vimapi-tabline-set-info "[$MY_PYTHON_TYPE,$MY_PYTHON_VENV][$MY_BUILD_SYS,$MY_BUILD_CONFIG]"
fi

