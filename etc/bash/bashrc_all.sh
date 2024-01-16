#!/bin/bash

export MY_BASH=$HOME/MyRoaming/env/etc/bash
export MY_COMMON_SETTING=$HOME/MyConfig/lconfig/common

rc_files="$MY_BASH/bashrc.??.*.sh"
rc_files="$rc_files $MY_COMMON_SETTING/bashrc.??.*.sh"

source $MY_BASH/bashrc.0.start.sh

for fname in $rc_files; do
  #echo $fname
  source_file $fname
done

source $MY_BASH/bashrc.999.end.sh
