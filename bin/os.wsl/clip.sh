#!/bin/bash

ps_file="$MY_LOCAL_CONFIG_WIN/bin/paste.ps1"

if [ -f $ps_file ]; then
  iconv -f utf8 -t utf16 | clip.exe
else
  clip.exe
fi
