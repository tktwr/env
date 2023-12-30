#!/bin/bash

export PATH="$SYS_CONFIG_HOME/opt/te210114:$PATH"
export PATH="$SYS_CONFIG_HOME/opt/te220627:$PATH"

dir="${*:-$PWD}"
url=$(eval "echo $dir")  # expand env variables
wp=$(pathconv.sh win "$dir")

exec $WINPTY TE64.exe "$wp" > /dev/null 2>&1 &
