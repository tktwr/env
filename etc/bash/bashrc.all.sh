#!/bin/bash

export MY_BASH=$HOME/MyConfig/tktwr.github/env/etc/bash

source $MY_BASH/bashrc.00.init.sh
source $MY_BASH/bashrc.10.colors.sh
source $MY_BASH/bashrc.10.path.sh
source $MY_BASH/bashrc.20.func.sh
source $MY_BASH/bashrc.21.prompt.sh
source $MY_BASH/bashrc.30.git.sh
source $MY_BASH/bashrc.31.git-prompt.sh
source $MY_BASH/bashrc.40.python.sh
source $MY_BASH/bashrc.41.conda.sh
source $MY_BASH/bashrc.50.os.$MY_OS_NAME.sh
source $MY_BASH/bashrc.80.alias.sh
source $MY_BASH/bashrc.81.my.sh
source $MY_BASH/bashrc.82.fzy.sh
source $MY_BASH/bashrc.90.setup.sh
