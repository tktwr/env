#!/bin/bash

dir="$1"
powershell.exe compress-archive "$dir" "$dir.zip"
