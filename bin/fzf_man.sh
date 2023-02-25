#!/bin/bash

man -k $1 | awk '{print $1}' | \
  fzf --prompt 'man> ' --preview 'man {}' --height 100% --preview-window up:70%;
