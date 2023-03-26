#!/bin/bash

# expand env variables
line=$(eval "echo $*")

if [ -d "$line" ]; then
  echo "dir: [$line]"
  te.sh "$line"
elif [ -f "$line" ]; then
  echo "file: [$line]"
  vscode.sh "$line"
fi
