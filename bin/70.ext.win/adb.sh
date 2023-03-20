#!/bin/bash

export PATH="$ANDROID_SDK/platform-tools:$PATH"

exec $WINPTY adb.exe "$@"
