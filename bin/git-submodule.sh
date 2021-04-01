#!/bin/bash

base_dir=$(pwd)
dirs=$(git submodule | awk '{print $2}')

for i in $dirs; do
  echo "========== [$i] =========="
  cd $i
  winpty git graph -2
  echo "---"
  winpty git status -s
  cd $base_dir
done

