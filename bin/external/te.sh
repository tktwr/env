#!/bin/bash

export PATH="$MY_PUBLIC/bin/te210114:$PATH"
export PATH="$MY_PUBLIC/bin/te220627:$PATH"

dir="${*:-$PWD}"
wp=$(pathconv.sh win "$dir")

exec $WINPTY TE64.exe "$wp" > /dev/null 2>&1 &
