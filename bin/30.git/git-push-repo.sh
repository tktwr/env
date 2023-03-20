#!/bin/bash

if [ $# -gt 0 ]; then
  git.exe remote add origin "$1"
  git.exe push -u origin --all
  git.exe push -u origin --tags
fi
