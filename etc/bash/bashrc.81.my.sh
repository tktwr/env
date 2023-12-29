#!/bin/bash

#======================================================
# my
#======================================================
#------------------------------------------------------
# mypushd.sh
#------------------------------------------------------
alias set.G='mypushd.sh --set `pwd`'
alias get.G='mypushd.sh --get'
alias cd.G='cd `mypushd.sh --get`'
mv.G() { mv "$@" `mypushd.sh --get`; }
cp.G() { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
alias l='exa-short.sh'
alias ls='ls.sh'
alias make='mymake.sh'
alias m='mymake.sh'

mycmake-set() {
  mycmake.sh --set $1 $2
  source_bashrc
}

#------------------------------------------------------
# vim terminal
#------------------------------------------------------
f_alias_vim_term() {
  alias ,f='vimapi-edit-dir'
  alias ,f2='vimapi-edit-dir-2'

  alias ,ide='vimapi_exec VisIDE'
  alias ,ide2='vimapi_exec VisIDE 2'
  alias ,edit='vimapi_exec new'
  alias ,editv='vimapi_exec vnew'
  alias ,term='vimapi_exec VisTerm'
  alias ,termv='vimapi_exec VisTermV'

  alias ,tab_ide='vimapi_exec_tab VisIDE'
  alias ,tab_ide2='vimapi_exec_tab VisIDE 2'
  alias ,tab_edit='vimapi_exec tabedit'
  alias ,tab_term='vimapi_exec tab VisTerm'

  alias ,resize='vimapi_exec VisWinResize'
  alias ,resize_x='vimapi_exec VisWinVResize'
  alias ,toggle='vimapi_exec VisWinMaximizeYToggleTerm'
  alias ,toggle_x='vimapi_exec VisWinMaximizeXToggleTerm'

  alias ,lg='vimapi_exec VisLazygit tab'
  alias ,man='vimapi_exec VisFzfMan tab'
  alias ,apt='vimapi_exec VisFzfApt tab'
  alias ,pip='vimapi_exec VisFzfPip tab'
  alias ,dpkg='vimapi_exec VisFzfDpkg tab'

  alias ,gs='vimapi_exec VisGS'
  alias ,gg='vimapi_exec VisGV'
  #alias ,gl='vimapi_exec_above GitLog $PWD'

  alias ,r=',toggle'
  alias ,rx=',toggle_x'
  alias ,r0=',resize 5'
  alias ,r1=',resize 10'
  alias ,r2=',resize 20'
  alias ,r3=',resize 30'
  alias ,r4=',resize 40'
}

f_alias_term() {
  if [ $MY_OS_NAME = 'gitbash' ]; then
    TERM_cygwin='TERM=cygwin'
  else
    TERM_cygwin=''
  fi
  alias ,ide="$TERM_cygwin vim -c 'VisIDE'"
  alias ,ide2="$TERM_cygwin vim -c 'VisIDE 2'"
  alias ,term="$TERM_cygwin vim -c 'VisTerm' -c 'only'"
  alias ,term2="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'VisTerm'"
  alias ,term2v="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'vert VisTerm'"

  alias ,nide='nvim -c "VisIDE"'
  alias ,nterm='nvim -c "VisTerm" -c "only"'
  alias ,nterm2='nvim -c "VisTerm" -c "only" -c "VisTerm"'
  alias ,nterm2v='nvim -c "VisTerm" -c "only" -c "vert VisTerm"'

  alias ,gs='vim -c "VisGS"'
  alias ,gg='vim -c "VisGV"'
}

#======================================================
# os
#======================================================
f_alias_wsl() {
  alias ,D='open_dir.sh'
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'
  alias gitbash='gitbash.sh'
}

f_alias_msys() {
  :
}

f_alias_gitbash() {
  alias ,D='open_dir.sh'
}

f_alias_linux() {
  alias ,D='open_dir.sh'
  #alias ,pdf='evince'
  alias ,pdf='qpdfview --unique'
  alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
}

f_alias_termux() {
  :
}

f_alias_common() {
  alias vim='vim.sh'
  alias vimdiff='vimdiff.sh'
  alias vimdirdiff='vimdirdiff.sh'
  alias vim-which='vim-which.sh'
  alias vim-where='vim-which.sh'
}

