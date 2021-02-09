#!/bin/bash

#======================================================
# git
#======================================================

f_get_prompt_color_host() {
  local CO
  case $HOSTNAME in
    *)
      CO=$ECO5
      ;;
  esac
  echo $CO$HOSTNAME
}

f_get_prompt_color_shell() {
  local CO
  case $MY_SHELL_NAME in
    gitbash)
      CO=$ECO1
      ;;
    MINGW64)
      CO=$ECO2
      ;;
    termux)
      CO=$ECO3
      ;;
    bash)
      CO=$ECO5
      ;;
  esac
  echo $CO$MY_SHELL_NAME
}

f_set_git_prompt() {
  source "$MY_ENV/etc/git/git-prompt.sh"
  source "$MY_ENV/etc/git/git-completion.bash"

  GIT_BRANCH_FUNC='`__git_ps1`'
  PS1_HOST=$(f_get_prompt_color_host)
  PS1_SHELL=$(f_get_prompt_color_shell)
  PS1_GIT=$ECO6${GIT_BRANCH_FUNC}

  export PROMPT_DIRTRIM=2
  export PS1="$PS1_HOST:$ECOR$PS1_SHELL$ECOD$ECO3[\w]$PS1_GIT$ECOD\$ "
}

#------------------------------------------------------
# git-alias
#------------------------------------------------------
alias gs='git status'
alias gd='git diff'
alias gf='git fetch'

alias gA='git add'
alias gAu='git add -u'
alias gC-amend='git commit --amend -m'

gC() {
  msg=${1:-"update"}
  git commit -m "$msg"
}

gAC() {
  msg=${1:-"update"}
  git commit -a -m "$msg"
}

alias gR='git reset --hard'
alias gRom='git reset --hard origin/$(git-branch-name)'
alias gPom='git push origin $(git-branch-name)'

alias git-submodule-update-all='git submodule update --init --recursive'
alias git-dirdiff='git difftool --dir-diff'

#------------------------------------------------------
# git (stage/unstage, track/untrack)
#------------------------------------------------------
alias git-stage='git add'
alias git-unstage='git reset --'

alias git-track='git add'
alias git-untrack-file='git rm --cached'
alias git-untrack-dir='git rm --cached -r'

git-chmod-x() {
  git update-index --add --chmod=+x "$@"
}

git-chmod-x-all() {
  git-chmod-x $(git-ls-no-x)
}

#------------------------------------------------------
# git-tmp
#------------------------------------------------------
git-tmp-commit() {
  git commit -a -m "[TMP] $*";
}

git-tmp-reset() {
  git reset HEAD^;
}

git-reset-last() {
  git reset HEAD^;
}

#------------------------------------------------------
# git (push/pull/merge/rebase)
#------------------------------------------------------
alias git-pull-no-commit='git pull --no-commit'
alias git-merge-no-commit='git merge --no-commit'

git-push-origin() {
  git push origin $(git-branch-name)
}

git-pull-origin() {
  git pull origin $(git-branch-name)
}

git-rebase-origin() {
  git rebase origin/$(git-branch-name)
}

git-merge-no-commit-origin() {
  git merge --no-commit origin/$(git-branch-name)
}

#------------------------------------------------------
# git-ls
#------------------------------------------------------
alias git-ls-track='git ls-files -s'
alias git-ls-untrack='git ls-files -o --directory'

git-ls-no-x() {
  git ls-files -s | grep '^100644' | awk '{print $4}'
}

alias gls='git-ls'

#------------------------------------------------------
# git-branch
#------------------------------------------------------
git-branch-name() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
  #git symbolic-ref --short HEAD 2>/dev/null
  #git branch --show-current 2>/dev/null
}

print-git-branch() {
  echo "[REMOTE]"
  git remote -v
  echo "[BRANCH]"
  git branch -a -vv
}

print-git-tag() {
  echo "[TAG]"
  git tag
  git ls-remote --tags
}

alias gb='print-git-branch'
alias gt='print-git-tag'

#------------------------------------------------------
# git-graph
#------------------------------------------------------
# less options
# -E or --QUIT-AT-EOF
# -F or --quit-if-one-screen
# -R or --RAW-CONTROL-CHARS
# -S or --chop-long-lines
# -X or --no-init
gg()   { git graph --color=always $* | less -EFRSX; }
gg-d() { git graph --color=always --date-order  $* | less -EFRSX; }
gg-s() { git graph --color=always --name-status $* | less -EFRSX; }

alias G='gg -15'

#------------------------------------------------------
# git-vim
#------------------------------------------------------
alias GG='vim -c "Agit"'
alias GV='vim -c "GV --all"'
alias S='vim -c "MyGstatusToggle"'

#------------------------------------------------------
