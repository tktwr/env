#!/bin/bash

export PATH="$SYS_PROG64_DIR/Epic Games/UE_5.0/Engine/Binaries/Win64:$PATH"

exec $WINPTY UnrealEditor-Cmd.exe "$@"
