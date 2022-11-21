#!/bin/bash

export MY_BASH=$HOME/MyRoaming/env/etc/bash
export MY_COMMON_SETTING=$HOME/MyConfig/lconfig/common

rc_files="$MY_BASH/bashrc.??.*.sh"
rc_files="$rc_files $MY_COMMON_SETTING/bashrc.??.*.sh"

for fname in $rc_files; do
  #echo $fname
  source $fname
done
