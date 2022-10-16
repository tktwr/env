#!/bin/bash

#======================================================
# git
#======================================================
#------------------------------------------------------
# func
#------------------------------------------------------
git-eval() {
  echo "$1"
  eval "$1"
}

#------------------------------------------------------
git-branch-name() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
  #git symbolic-ref --short HEAD 2>/dev/null
  #git branch --show-current 2>/dev/null
}

git-commit-hash() {
  git rev-parse --short HEAD 2>/dev/null
}

git-commit-hash-long() {
  git rev-parse HEAD 2>/dev/null
}

#------------------------------------------------------
# print
#------------------------------------------------------
git-print-branch-all() {
  echo "[REMOTE]"
  git remote -v
  echo "[BRANCH]"
  git branch -a -vv
}

git-print-tag-all() {
  echo "[TAG]"
  git tag
  git ls-remote --tags
}

#------------------------------------------------------
# git-ls
#------------------------------------------------------
git-ls-track() {
  git ls-files -s
}

git-ls-untrack() {
  git ls-files -o --directory
}

git-ls-no-x() {
  git ls-files -s | grep '^100644' | awk '{print $4}'
}

#------------------------------------------------------
# chmod
#------------------------------------------------------
git-chmod-x() {
  git update-index --add --chmod=+x "$@"
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# git-graph
#------------------------------------------------------
# less options
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init
git-graph() {
  git graph --color=always $* | less -EFRSX
}

git-graph-date() {
  git graph --color=always --date-order  $* | less -EFRSX
}

git-graph-status() {
  git graph --color=always --name-status $* | less -EFRSX
}

#------------------------------------------------------
# git-branch
#------------------------------------------------------
git-branch-reset() {
  br=$(prompt.sh 'branch' 'master' "$*")
  if [ -n "$br" ]; then
    git-eval "git branch -f $br HEAD"
    git-eval "git checkout $br"
  fi
}

git-branch-create() {
  br=$(prompt.sh 'branch' 'tmp' "$*")
  if [ -n "$br" ]; then
    git-eval "git branch $br"
  fi
}

git-branch-delete() {
  br=$(prompt.sh 'branch' '' "$*")
  if [ -n "$br" ]; then
    git-eval "git branch -d $br"
  fi
}

git-remote-branch-delete() {
  br=$(prompt.sh 'branch' '' "$*")
  if [ -n "$br" ]; then
    git-eval "git push origin :$br"
  fi
}

#------------------------------------------------------
# git (stage/unstage, track/untrack)
#------------------------------------------------------
git-stage() {
  git add "$@"
}

git-unstage() {
  git reset -- "$@"
}

git-track() {
  git add "$@"
}

git-untrack-file() {
  git rm --cached "$@"
}

git-untrack-dir() {
  git rm --cached -r "$@"
}

#------------------------------------------------------
# git commit
#------------------------------------------------------
git-commit-amend() {
  msg=${1:-"amend"}
  git commit --amend -m "$msg"
}

git-commit() {
  msg=${1:-"update"}
  git commit -m "$msg"
}

git-add-commit() {
  msg=${1:-"update"}
  git commit -a -m "$msg"
}

#------------------------------------------------------
# git tmp
#------------------------------------------------------
git-commit-tmp() {
  msg=$(prompt.sh 'message' '[TMP] update' "$*")
  if [ -n "$msg" ]; then
    git-eval "git commit -a -m $msg"
  fi
}

git-reset-tmp() {
  git-eval "git reset HEAD~"
}

git-reset-last() {
  git-eval "git reset HEAD~"
}

#------------------------------------------------------
# git (push/pull/merge/rebase)
#------------------------------------------------------
git-push-origin() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git push origin $br
  fi
}

git-pull-origin() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git pull origin $br
  fi
}

git-pull-no-commit() {
  git pull --no-commit
}

git-rebase-origin() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git rebase origin/$br
  fi
}

git-rebase-abort() {
  git rebase --abort
}

git-merge-abort() {
  git merge --abort
}

git-merge-no-ff() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git merge --no-ff $br
  fi
}

git-merge-no-commit() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git merge --no-commit $br
  fi
}

git-merge-no-commit-origin() {
  br=$(prompt.sh 'branch' "$(git-branch-name)" "$*")
  if [ -n "$br" ]; then
    git merge --no-commit origin/$br
  fi
}

#------------------------------------------------------
# git reset
#------------------------------------------------------
git-reset-hard() {
  git reset --hard "$@"
}

git-reset-hard-origin() {
  git reset --hard origin/$(git-branch-name)
}

#------------------------------------------------------
# others
#------------------------------------------------------
git-clone-recursive-shallow() {
  git clone --depth 1 --recurse-submodules --shallow-submodules "$@"
}

git-clone-recursive() {
  git clone --recurse-submodules "$@"
}

git-submodule-update-all() {
  git submodule update --init --recursive
}

git-dirdiff() {
  git difftool --dir-diff
}

#------------------------------------------------------
# git-alias
#------------------------------------------------------
alias gs='git status'
alias gS='git status -s'
alias gd='git diff'
alias gD='git diff --staged'
alias gf='git fetch'
alias gg='git graph'
alias gb='git branch'
alias gt='git tag'

alias gA='git add'
alias gAu='git add -u'
alias gAC='git-add-commit'
alias gC='git-commit'

alias gbR='git-branch-reset'
alias gR='git reset --hard'
alias gRom='git-reset-hard-origin'
alias gPom='git-push-origin'

alias G='git-graph-date -6'
alias GA='git-graph-date -6 --all'
alias GM='git-log.sh --log 4 --log-submodule 2'

alias gls='git-ls.sh'
alias gba='git-print-branch-all'
alias gta='git-print-tag-all'
