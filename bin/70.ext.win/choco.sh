#!/bin/bash

export PATH="$SYS_C/ProgramData/chocolatey/bin:$PATH"

exec $WINPTY choco.exe "$@"
