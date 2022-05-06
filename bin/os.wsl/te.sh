#!/bin/bash

export PATH="$MY_PUBLIC/bin/te210114:$PATH"

wp=$(pathconv.sh win "$*")
exec TE64.exe "$wp" > /dev/null 2>&1 &
