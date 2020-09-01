#!/bin/bash

git-chmod-x-all() {
  files=`git ls-files -s | grep '^100644' | awk '{print $4}'`
  git update-index --add --chmod=+x $files
}

git-chmod-x-all

