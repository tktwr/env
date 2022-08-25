#!/bin/bash

export PATH="/c/ProgramData/chocolatey/bin:$PATH"

exec $WINPTY choco.exe "$@"
