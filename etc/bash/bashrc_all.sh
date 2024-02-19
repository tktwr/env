#!/bin/bash

export MY_BASH=$HOME/MyRoaming/env/etc/bash
export MY_COMMON_SETTING=$HOME/MyConfig/lconfig/common


source $MY_BASH/bashrc.0.start.sh
source_file $MY_BASH/bashrc_zero.sh
source_file $MY_BASH/bashrc.??.*.sh
source_file $MY_COMMON_SETTING/bashrc.??.*.sh
source_file $MY_BASH/bashrc.999.end.sh
