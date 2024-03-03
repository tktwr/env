#!/bin/bash

f_git_diff() {
  git diff > _output_git_diff.diff
}
f_git_patch() {
  git apply _output_git_diff.diff
  #patch -p1 < _output_git_diff.diff
}
