#!/bin/bash

fzf_rg() {
  cmd="rg --column --line-number --no-heading --color=always --smart-case -- '$*'"
  eval $cmd | fzf --ansi
}

fzf_rg "$*"
