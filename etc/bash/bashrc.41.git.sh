#!/bin/bash

#======================================================
# git
#======================================================
#------------------------------------------------------
# alias
#------------------------------------------------------
alias g='git-default.sh'

alias gs='$SYS_GIT_EXE status'
alias gS='$SYS_GIT_EXE status -s'
alias gd='$SYS_GIT_EXE diff'
alias gD='$SYS_GIT_EXE diff --staged'
alias gf='$SYS_GIT_EXE fetch'
alias gg='$SYS_GIT_EXE graph'
alias gb='$SYS_GIT_EXE branch'
alias gt='$SYS_GIT_EXE tag'

alias gA='$SYS_GIT_EXE add'
alias gAu='$SYS_GIT_EXE add -u'
alias gAC='cmd.sh f_git_commit_add'
alias gC='cmd.sh f_git_commit'

alias gR='$SYS_GIT_EXE reset --hard'
alias gRom='cmd.sh f_git_reset_hard_origin'
alias gPom='cmd.sh f_git_push_origin'

alias G='git-graph.sh --date-order -6'
alias GA='git-graph.sh --date-order -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

alias gba='cmd.sh f_git_print_branch_all'
alias gta='cmd.sh f_git_print_tag_all'

alias cd.root='cd $(cmd.sh f_git_root)'
alias .root='pushd $(cmd.sh f_git_root)'
