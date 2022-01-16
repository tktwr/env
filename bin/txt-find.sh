#!/bin/bash

find $* \( -type d \( -name '.git' -o -name '.svn' -o -name 'build*' -o -name '__pycache__' \) -prune \) -o \( -type f -not \( -name '*.jpg' -o -name '*.png' \) -print \)

