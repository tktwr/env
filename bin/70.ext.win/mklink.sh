#!/bin/bash

dst=$1
src=$2

exec $WINPTY cmd.exe /c "mklink /j $dst $src"

