#!/bin/bash

cd `tmux display-message -p -F "#{pane_current_path}"`
#branch_name=$(git branch --show-current 2>/dev/null)
branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
[ ! -z ${branch_name} ] && echo "${branch_name}"
