#!/bin/bash

ps_file="$MY_LOCAL_CONFIG_WIN/bin/paste.ps1"

if [ -f $ps_file ]; then
  powershell.exe $ps_file
else
  powershell.exe -OutputFormat Text -Command Get-Clipboard
fi
