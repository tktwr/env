#!/bin/sh

find $* \( -type d \( -name '.git' -o -name '.svn' -o -name 'build*' \) -prune \) -o \( -type f -not \( -name '*.jpg' -o -name '*.png' \) -print \)

