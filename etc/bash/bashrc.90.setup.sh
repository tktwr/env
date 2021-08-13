#!/bin/bash

#======================================================
# setup
#======================================================

f_set_core_off
f_select_python $MY_PYTHON_TYPE
f_activate_python $MY_PYTHON_TYPE $MY_PYTHON_VENV

case $MY_PROMPT_TYPE in
  'minimal')
    f_set_prompt_minimal
    ;;
  'git')
    f_set_prompt_git
    ;;
  'git-fast')
    f_set_prompt_git_fast
    ;;
esac

