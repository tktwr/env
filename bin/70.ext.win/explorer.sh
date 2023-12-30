#!/bin/bash

dir="${*:-$PWD}"
url=$(eval "echo $dir")  # expand env variables
wp=$(pathconv.sh win "$dir")

exec $WINPTY explorer.exe "$wp" > /dev/null 2>&1 &
