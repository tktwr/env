#!/bin/bash

wp=$(pathconv.sh win "$*")
exec $WINPTY explorer.exe "$wp" > /dev/null 2>&1 &
