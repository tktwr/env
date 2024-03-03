#!/bin/bash

#======================================================
# git
#======================================================
#------------------------------------------------------
# print
#------------------------------------------------------
git-root() {
  git rev-parse --show-toplevel 2> /dev/null
}

git-branch-name() {
  $SYS_GIT_EXE rev-parse --abbrev-ref HEAD 2>/dev/null
  #$SYS_GIT_EXE symbolic-ref --short HEAD 2>/dev/null
  #$SYS_GIT_EXE branch --show-current 2>/dev/null
}

git-commit-hash() {
  commit=${1:-HEAD}
  $SYS_GIT_EXE rev-parse --short $commit 2>/dev/null
}

git-commit-hash-long() {
  commit=${1:-HEAD}
  $SYS_GIT_EXE rev-parse $commit 2>/dev/null
}

git-print-branch-all() {
  echo "[REMOTE]"
  $SYS_GIT_EXE remote -v
  echo "[BRANCH]"
  $SYS_GIT_EXE branch --color=always -a -vv | $GIT_PAGER
}

git-print-tag-all() {
  echo "[TAG]"
  $SYS_GIT_EXE tag
  $SYS_GIT_EXE ls-remote --tags
}

#------------------------------------------------------
# cd
#------------------------------------------------------
git-cd-root() {
  topdir=$(git-root)
  if [ -n "$topdir" ]; then
    cd $topdir
  fi
}

#------------------------------------------------------
# graph
#------------------------------------------------------
git-graph() {
  git-graph.sh "$@"
}

git-graph-date() {
  git-graph.sh --date-order "$@"
}

git-graph-status() {
  git-graph.sh --name-status "$@"
}

#------------------------------------------------------
# ls
#------------------------------------------------------
git-ls-track() {
  $SYS_GIT_EXE ls-files -s
}

git-ls-untrack() {
  $SYS_GIT_EXE ls-files -o --directory
}

git-ls-no-x() {
  $SYS_GIT_EXE ls-files -s | grep '^100644' | awk '{print $4}'
}

#------------------------------------------------------
# chmod
#------------------------------------------------------
git-chmod-x() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE update-index --add --chmod=+x "$@"
  else
    echo "git-chmod-x {file}"
  fi
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# branch
#------------------------------------------------------
git-reset-branch() {
  br=$(prompt.sh 'Reset branch' 'master' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch -f $br HEAD
    $SYS_GIT_EXE checkout $br
  fi
}

git-create-branch() {
  br=$(prompt.sh 'Create branch' 'tmp' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch $br
  fi
}

git-delete-branch() {
  $SYS_GIT_EXE branch
  br=$(prompt.sh 'Delete branch' '' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE branch -d $br
  fi
}

git-delete-branch-origin() {
  br=$(prompt.sh 'Delete remote branch' '' "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE push origin :$br
  fi
}

#------------------------------------------------------
# stage/unstage
#------------------------------------------------------
git-stage() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE add "$@"
  fi
}

git-unstage() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE reset -- "$@"
  fi
}

#------------------------------------------------------
# track/untrack
#------------------------------------------------------
git-track() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE add "$@"
  fi
}

git-untrack() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE rm --cached -r "$@"
  fi
}

#------------------------------------------------------
# commit
#------------------------------------------------------
git-commit() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $SYS_GIT_EXE commit -m "$msg"
}

git-commit-add() {
  msg=$(prompt.sh 'Commit message' 'update' "$*")
  $SYS_GIT_EXE commit -a -m "$msg"
}

git-commit-amend() {
  msg=$(prompt.sh 'Amend commit message' 'amend' "$*")
  $SYS_GIT_EXE commit --amend -m "$msg"
}

#------------------------------------------------------
# reset
#------------------------------------------------------
git-reset-last() {
  $SYS_GIT_EXE reset HEAD~
}

git-reset-hard() {
  $SYS_GIT_EXE reset --hard "$@"
}

git-reset-hard-origin() {
  $SYS_GIT_EXE reset --hard origin/$(git-branch-name)
}

#------------------------------------------------------
# push/pull
#------------------------------------------------------
git-push-origin() {
  br=$(prompt.sh 'Push branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE push origin $br
  fi
}

git-pull-origin() {
  br=$(prompt.sh 'Pull branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE pull origin $br
  fi
}

#------------------------------------------------------
# merge/rebase
#------------------------------------------------------
git-merge() {
  br=$(prompt.sh 'Merge branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE merge --no-ff $br
  fi
}

git-merge-abort() {
  $SYS_GIT_EXE merge --abort
}

git-rebase() {
  br=$(prompt.sh 'Rebase branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    $SYS_GIT_EXE rebase $br
  fi
}

git-rebase-abort() {
  $SYS_GIT_EXE rebase --abort
}

#------------------------------------------------------
# tmp
#------------------------------------------------------
git-tmp() {
  msg=$(prompt.sh 'Commit message' '[TMP] update' "$*")
  if [ -n "$msg" ]; then
    $SYS_GIT_EXE commit -a -m "$msg"
  fi
}

git-tmp-reset() {
  $SYS_GIT_EXE reset HEAD~
}

#------------------------------------------------------
# others
#------------------------------------------------------
git-clone-shallow() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --depth 1 "$@"
  fi
}

git-clone-shallow-recursive() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --depth 1 --recurse-submodules --shallow-submodules "$@"
  fi
}

git-clone-recursive() {
  if [ $# -gt 0 ]; then
    $SYS_GIT_EXE clone --recurse-submodules "$@"
  fi
}

git-submodule-update-all() {
  $SYS_GIT_EXE submodule update --init --recursive
}

git-dirdiff() {
  $SYS_GIT_EXE difftool --dir-diff
}

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
alias gAC='git-commit-add'
alias gC='git-commit'

alias gR='$SYS_GIT_EXE reset --hard'
alias gRom='git-reset-hard-origin'
alias gPom='git-push-origin'

alias G='git-graph-date -6'
alias GA='git-graph-date -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

alias gba='git-print-branch-all'
alias gta='git-print-tag-all'

alias cd.root='cd $(git-root)'
alias .root='pushd $(git-root)'
