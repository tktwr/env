#!/bin/bash

git-default() {
  if [ $# -eq 0 ]; then
    $SYS_GIT_EXE status -s
  else
    $SYS_GIT_EXE "$@"
  fi
}

git-default "$@"
