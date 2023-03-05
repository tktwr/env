#!/bin/bash

man -k '' | \
  fzf --prompt 'man> ' --preview 'preview_man.sh {}'
