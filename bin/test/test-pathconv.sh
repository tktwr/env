#!/bin/bash

files="\
$HOME/.bashrc \
$HOME/WinHome/.bashrc \
$HOME/.not_existing_file \
$HOME/WinHome/.not_existing_file \
"

echo "--- pathconv.sh ---"
for i in $files; do
  pathconv.sh unix $i
  pathconv.sh win $i
done

echo "--- pathconv.py ---"
for i in $files; do
  pathconv.py -t unix $i
  pathconv.py -t windows $i
done
