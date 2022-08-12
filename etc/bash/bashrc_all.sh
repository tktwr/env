#!/bin/bash

export MY_BASH=$HOME/MyRoaming/env/etc/bash

source $MY_BASH/bashrc_start.sh

source_file $MY_BASH/bashrc.00.init.sh
source_file $MY_BASH/bashrc.01.colors_gruvbox.sh
source_file $MY_BASH/bashrc.10.path.sh
source_file $MY_BASH/bashrc.11.func.sh
source_file $MY_BASH/bashrc.20.prompt.sh
source_file $MY_BASH/bashrc.21.prompt_git.sh
source_file $MY_BASH/bashrc.22.prompt_git_fast.sh
source_file $MY_BASH/bashrc.30.git.sh
source_file $MY_BASH/bashrc.40.python.sh
source_file $MY_BASH/bashrc.41.cmake.sh
source_file $MY_BASH/bashrc.50.os.$MY_OS_NAME.sh
source_file $MY_BASH/bashrc.80.alias.sh
source_file $MY_BASH/bashrc.81.my.sh
source_file $MY_BASH/bashrc.82.fzy.sh
source_file $MY_BASH/bashrc.90.setup.sh

source_file $MY_COMMON_SETTING/bashrc.0?.*.sh
source_file $MY_COMMON_SETTING/bashrc.1?.*.$MY_OS_NAME.sh

