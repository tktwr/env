#!/bin/bash

#======================================================
# setup
#======================================================
# opencv's openexr feature is disabled in default for security issues
# the following env variable enable it
export OPENCV_IO_ENABLE_OPENEXR=1

f_set_core_off
f_set_prompt

#------------------------------------------------------
# python
#------------------------------------------------------
mypython-type $MY_PYTHON_TYPE
mypython-venv-activate $MY_PYTHON_VENV

#------------------------------------------------------
# vim
#------------------------------------------------------
my_setup_vim

#------------------------------------------------------
# os
#------------------------------------------------------
f_os_$MY_OS_NAME

#------------------------------------------------------
# alias
#------------------------------------------------------
f_alias_common
f_alias_$MY_OS_NAME
if [ "$VIM_TERMINAL" ]; then
  f_alias_vim_term
else
  f_alias_term
fi

#------------------------------------------------------
# path
#------------------------------------------------------
case $MY_OS_NAME in
  wsl)
    f_ins_path "$SYS_ROAMING_HOME/opt/bat"
    f_ins_path "$SYS_ROAMING_HOME/opt/delta"
    f_ins_path "$SYS_ROAMING_HOME/opt/lazygit"
    f_ins_path "$SYS_ROAMING_HOME/opt/exa/bin"
    ;;
  msys|gitbash)
    f_ins_path "$SYS_CONFIG_HOME/opt/winget"
    ;;
esac

# on Windows FS
f_add_path "$SYS_CONFIG_HOME/lconfig/bin"
f_add_path "$SYS_CONFIG_HOME/opt/bin"

# OS dependent wrapper
f_ins_path "$MY_ENV/bin/os.$MY_OS_NAME"
