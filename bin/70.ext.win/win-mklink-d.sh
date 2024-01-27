#!/bin/bash

dst_dir=$(wslpath -aw "$1")
src_dir=$(wslpath -aw "$2")

# make a junction on NTFS
$WINPTY cmd.exe /c mklink /d "$dst_dir" "$src_dir"
