#!/bin/bash

export MY_CONFIG=$HOME/MyConfig
export MY_BASH=$MY_CONFIG/tktwr.github/env/etc/bash

source $MY_BASH/bashrc.00.init.sh
source $MY_BASH/bashrc.01.colors.sh
source $MY_BASH/bashrc.10.path.sh
source $MY_BASH/bashrc.11.func.sh
source $MY_BASH/bashrc.20.prompt.sh
source $MY_BASH/bashrc.21.prompt_git.sh
source $MY_BASH/bashrc.22.prompt_git_fast.sh
source $MY_BASH/bashrc.30.git.sh
source $MY_BASH/bashrc.40.python.sh
source $MY_BASH/bashrc.41.conda.sh
source $MY_BASH/bashrc.50.os.$MY_OS_NAME.sh
source $MY_BASH/bashrc.80.alias.sh
source $MY_BASH/bashrc.81.my.sh
source $MY_BASH/bashrc.82.fzy.sh
source $MY_BASH/bashrc.90.setup.sh

source_file $MY_CONFIG/common/bashrc.local.sh

