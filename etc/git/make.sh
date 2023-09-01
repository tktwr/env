#!/bin/bash

#======================================================
# variables
#======================================================

#======================================================
# functions
#======================================================
f_wsl() {
  mkdir -p wsl
  cd wsl
  cp /usr/lib/git-core/git-sh-prompt git-prompt.sh
  cp /usr/share/bash-completion/completions/git git-completion.bash
}

f_gitbash() {
  mkdir -p gitbash
  cd gitbash
  COMPLETION_PATH="$SYS_PROG64_DIR/Git/mingw64/share/git/completion"
  cp "$COMPLETION_PATH/git-prompt.sh" .
  cp "$COMPLETION_PATH/git-completion.bash" .
}

#======================================================
# main
#======================================================
f_fzf_main "$@"
