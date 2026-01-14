#!/bin/bash

#------------------------------------------------------
# info
#------------------------------------------------------
f_git_root() {
  git rev-parse --show-toplevel 2> /dev/null
}

f_git_has_remote_branch() {
  $SYS_GIT_EXE rev-parse --abbrev-ref --symbolic-full-name @{u} >/dev/null 2>&1
}

f_git_remote_branch_name() {
  $SYS_GIT_EXE rev-parse --abbrev-ref --symbolic-full-name @{u}
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
  echo "[SUBMODULE]"
  $SYS_GIT_EXE submodule
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
  $SYS_GIT_EXE graph "$@"
}

f_git_graph_date() {
  $SYS_GIT_EXE graph --date-order "$@"
}

f_git_graph_status() {
  $SYS_GIT_EXE graph --name-status "$@"
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
  $SYS_GIT_EXE submodule update --init --recursive --remote --rebase
  #$SYS_GIT_EXE commit -a -m "update submodule"
}
f_git_submodule_status() {
  $SYS_GIT_EXE status -s
  $SYS_GIT_EXE submodule status --recursive
  $SYS_GIT_EXE submodule summary
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

#------------------------------------------------------
# need
#------------------------------------------------------
f_git_need_commit() {
  if ! $SYS_GIT_EXE diff --quiet || ! $SYS_GIT_EXE diff --cached --quiet; then
    return 1
  fi
  return 0
}
f_git_remote_status() { $SYS_GIT_EXE rev-list --left-right --count @{u}...HEAD; }
f_git_need_push() {
  if f_git_has_remote_branch; then
    local behind ahead
    read behind ahead < <(f_git_remote_status)
    if [ "$ahead" -gt 0 ]; then
      return 1
    fi
  fi
  return 0
}
f_git_need_action() {
  f_git_need_commit ; local need_commit=$?
  f_git_need_push   ; local need_push=$?

  if [ "$need_commit" -eq 1 ] && [ "$need_push" -eq 1 ]; then
    echo "need_commit need_push"; return 3
  elif [ "$need_commit" -eq 1 ]; then
    echo "need_commit"; return 1
  elif [ "$need_push" -eq 1 ]; then
    echo "need_push"; return 2
  else
    echo "clean"; return 0
  fi
}
#------------------------------------------------------
# ci
#------------------------------------------------------
f_git_ci_summary() {
  local mark_c="  "
  local mark_r="  "
  local behind ahead
  local esc=$'\e'

  f_git_need_commit ; local need_commit=$?
  if [ "$need_commit" -eq 1 ]; then
    mark_c="${esc}[31m✘ ${esc}[0m" # need_commit
  else
    mark_c="${esc}[32m✔ ${esc}[0m" # clean
  fi

  if f_git_has_remote_branch; then
    read behind ahead < <(f_git_remote_status)
    if [ "$behind" -gt 0 ]; then
      mark_r="${esc}[34m $behind${esc}[0m" # need_pull
    elif [ "$ahead" -gt 0 ]; then
      mark_r="${esc}[37m $ahead${esc}[0m" # need_push
    fi
  fi

  echo "[$mark_c$mark_r] $(f_git_ci_graph --color=never)"

  f_git_ci_status
}

f_git_ci_info() {
  f_git_print_branch_all
}

f_git_ci_graph() {
  $SYS_GIT_EXE graph -1 "$@"
}

f_git_ci_status() {
  $SYS_GIT_EXE status -s
}

f_git_ci_commit() {
  f_git_need_commit; local need_commit=$?
  if [ $need_commit -eq 1 ]; then
    $SYS_GIT_EXE commit -a -m 'update'
  fi
}

f_git_ci_fetch() {
  if f_git_has_remote_branch; then
    $SYS_GIT_EXE fetch
  fi
}

f_git_ci_pull() {
  if f_git_has_remote_branch; then
    $SYS_GIT_EXE pull
  fi
}

f_git_ci_push() {
  f_git_need_push; local need_push=$?
  if [ $need_push -eq 1 ]; then
    f_git_push_origin
  fi
}

#------------------------------------------------------
f_git_repo_master_to_main() {
  $SYS_GIT_EXE branch -m master main
  $SYS_GIT_EXE push -u origin main
  $SYS_GIT_EXE branch -vv
}

f_git_repo_delete_remote_master() {
  # githubでデフォルトブランチをmainに変更後
  $SYS_GIT_EXE push origin --delete master
}

f_git_remote_none() {
  $SYS_GIT_EXE remote rm origin
}

