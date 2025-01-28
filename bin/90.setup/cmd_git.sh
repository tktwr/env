#!/bin/bash

#------------------------------------------------------
# info
#------------------------------------------------------
f_git_root() {
  git rev-parse --show-toplevel 2> /dev/null
}

f_git_branch_name() {
  $SYS_GIT_EXE rev-parse --abbrev-ref HEAD 2>/dev/null
  #$SYS_GIT_EXE symbolic-ref --short HEAD 2>/dev/null
  #$SYS_GIT_EXE branch --show-current 2>/dev/null
}

f_git_commit_hash() {
  commit=${1:-HEAD}
  $SYS_GIT_EXE rev-parse --short $commit 2>/dev/null
}

f_git_commit_hash_long() {
  commit=${1:-HEAD}
  $SYS_GIT_EXE rev-parse $commit 2>/dev/null
}

f_git_config() {
  $SYS_GIT_EXE config --list
}
#------------------------------------------------------
# cd
#------------------------------------------------------
f_git_cd_root() {
  topdir=$(f_git_root)
  if [ -n "$topdir" ]; then
    cd $topdir
  fi
}

#------------------------------------------------------
# print
#------------------------------------------------------
f_git_print_branch_all() {
  echo "[REMOTE]"
  $SYS_GIT_EXE remote -v
  echo "[BRANCH]"
  $SYS_GIT_EXE branch --color=always -a -vv | $GIT_PAGER
}

f_git_print_tag_all() {
  echo "[TAG]"
  $SYS_GIT_EXE tag
  $SYS_GIT_EXE ls-remote --tags
}

#------------------------------------------------------
# graph
#------------------------------------------------------
f_git_graph() {
  git-graph.sh "$@"
}

f_git_graph_date() {
  git-graph.sh --date-order "$@"
}

f_git_graph_status() {
  git-graph.sh --name-status "$@"
}

#------------------------------------------------------
# ls
#------------------------------------------------------
f_git_ls_track() {
  $SYS_GIT_EXE ls-files -s
}

f_git_ls_untrack() {
  $SYS_GIT_EXE ls-files -o --directory
}

f_git_ls_no_x() {
  $SYS_GIT_EXE ls-files -s | grep '^100644' | awk '{print $4}'
}

#------------------------------------------------------
# chmod
#------------------------------------------------------
f_git_chmod_x() {
  # f_git_chmod_x {files...}
  if [ $# -gt 0 ]; then
    #$SYS_GIT_EXE update-index --add --chmod=+x "$@"
    chmod +x "$@"
  fi
}

f_git_chmod_x_all() {
  f_git_chmod_x $(f_git_ls_no_x)
}

#------------------------------------------------------
# track/untrack
#------------------------------------------------------
f_git_track() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE add "$@"
  fi
}

f_git_untrack() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE rm --cached -r "$@"
  fi
}

#------------------------------------------------------
# stage/unstage
#------------------------------------------------------
f_git_stage() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE add "$@"
  fi
}

f_git_unstage() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE reset -- "$@"
  fi
}

#------------------------------------------------------
# commit
#------------------------------------------------------
f_git_commit() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $SYS_GIT_EXE commit -m "$msg"
}

f_git_commit_add() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $SYS_GIT_EXE commit -a -m "$msg"
}

f_git_commit_amend() {
  msg=$(prompt.sh 'Amend commit message' 'amend' "$*")
  $SYS_GIT_EXE commit --amend -m "$msg"
}

#------------------------------------------------------
# reset
#------------------------------------------------------
f_git_reset_last() {
  $SYS_GIT_EXE reset HEAD~
}

f_git_reset_hard() {
  $SYS_GIT_EXE reset --hard "$@"
}

f_git_reset_hard_origin() {
  $SYS_GIT_EXE reset --hard origin/$(f_git_branch_name)
}

#------------------------------------------------------
# branch
#------------------------------------------------------
f_git_branch_reset() {
  br=$(prompt.sh 'Reset branch' 'master' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch -f $br HEAD
    $SYS_GIT_EXE checkout $br
  fi
}

f_git_branch_create() {
  br=$(prompt.sh 'Create branch' 'tmp' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch $br
  fi
}

f_git_branch_delete() {
  $SYS_GIT_EXE branch
  br=$(prompt.sh 'Delete branch' '' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch -d $br
  fi
}

#------------------------------------------------------
# remote branch
#------------------------------------------------------
f_git_remote_branch_delete() {
  br=$(prompt.sh 'Delete remote branch' '' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE push origin :$br
  fi
}

#------------------------------------------------------
# push
#------------------------------------------------------
f_git_push_origin() {
  br=$(prompt.sh 'Push branch' "$(f_git_branch_name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE push origin $br
  fi
}

#------------------------------------------------------
# pull
#------------------------------------------------------
f_git_pull_origin() {
  br=$(prompt.sh 'Pull branch' "$(f_git_branch_name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE pull origin $br
  fi
}

#------------------------------------------------------
# merge
#------------------------------------------------------
f_git_merge() {
  br=$(prompt.sh 'Merge branch' "$(f_git_branch_name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE merge --no-ff $br
  fi
}

f_git_merge_abort() {
  $SYS_GIT_EXE merge --abort
}

#------------------------------------------------------
# rebase
#------------------------------------------------------
f_git_rebase() {
  br=$(prompt.sh 'Rebase branch' "origin/$(f_git_branch_name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE rebase $br
  fi
}

f_git_rebase_abort() {
  $SYS_GIT_EXE rebase --abort
}

f_git_rebase_continue() {
  $SYS_GIT_EXE rebase --continue
}

#------------------------------------------------------
# wip
#------------------------------------------------------
f_git_wip() {
  msg=$(prompt.sh 'Commit message' '[WIP] update' "$*")
  if [ -n "$msg" ]; then
    $SYS_GIT_EXE commit -a -m "$msg"
  fi
}

f_git_wip_reset() {
  $SYS_GIT_EXE reset HEAD~
}

#------------------------------------------------------
# clone
#------------------------------------------------------
f_git_clone_shallow() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --depth 1 "$@"
  fi
}

f_git_clone_shallow_recursive() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --depth 1 --recurse-submodules --shallow-submodules "$@"
  fi
}

f_git_clone_recursive() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --recurse-submodules "$@"
  fi
}

f_git_submodule_update_all() {
  $SYS_GIT_EXE submodule update --init --recursive
}

#------------------------------------------------------
# diff
#------------------------------------------------------
f_git_diff() {
  git diff > _output_git_diff.diff
}

f_git_patch() {
  git apply _output_git_diff.diff
  #patch -p1 < _output_git_diff.diff
}

f_git_dirdiff() {
  $SYS_GIT_EXE difftool --dir-diff
}

