#!/bin/bash

$SYS_CONFIG_HOME/opt/winget/delta.exe -s --wrap-max-lines 0 --dark --paging=never "$@"
#$SYS_CONFIG_HOME/opt/winget/delta.exe "$@"
