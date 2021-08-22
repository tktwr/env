#!/bin/bash

#======================================================
# setup
#======================================================

f_set_core_off
f_select_python $MY_PYTHON_TYPE
f_activate_python $MY_PYTHON_TYPE $MY_PYTHON_VENV

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

if [ "$VIM_TERMINAL" ]; then
  vimapi-tabline-set-info
fi

