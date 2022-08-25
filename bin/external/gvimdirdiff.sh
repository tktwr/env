#!/bin/bash

exec $WINPTY gvim.exe -c "DirDiff $1 $2"

