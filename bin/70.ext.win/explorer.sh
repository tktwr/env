#!/bin/bash

dir="${*:-$PWD}"
wp=$(pathconv.sh win "$dir")

exec $WINPTY explorer.exe "$wp" > /dev/null 2>&1 &
