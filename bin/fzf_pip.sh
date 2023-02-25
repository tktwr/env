#!/bin/bash

pip list "$@" 2> /dev/null | \
  fzf --prompt 'pip> ' --preview 'pip show $(echo {} | cut -d " " -f 1) 2> /dev/null'
