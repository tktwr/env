#!/bin/bash

git-root() {
  git rev-parse --show-toplevel 2> /dev/null
}

git_root=$(git-root)

if [ -n "$git_root" ]; then
  LANG=C lazygit
fi
