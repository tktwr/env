#!/bin/bash

dst=$1
src=$2

cmd.exe /c "mklink /j $dst $src"

