#!/bin/bash

dir="${*:-$PWD}"
wp=$(_f_expand_win "$dir")

exec $WINPTY explorer.exe "$wp" > /dev/null 2>&1 &
