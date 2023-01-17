#!/bin/bash

apt list "$@" 2> /dev/null | \
  fzf --prompt 'apt > ' --preview 'apt show $(echo {} | cut -d '/' -f 1) 2> /dev/null'
