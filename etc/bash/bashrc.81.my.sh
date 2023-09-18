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
  alias ,F='vimapi-edit-dir'
  alias ,F2='vimapi-edit-dir-2'

  alias ,I='vimapi_exec VisIDE'
  alias ,I2='vimapi_exec VisIDE 2'
  alias ,It='vimapi_exec_tab VisIDE'

  alias ,N='vimapi_exec new'
  alias ,Nv='vimapi_exec vnew'
  alias ,Nt='vimapi_exec tabedit'

  alias ,T='vimapi_exec VisTerm'
  alias ,Tv='vimapi_exec VisTermV'
  alias ,Tt='vimapi_exec tab VisTerm'

  alias ,resize='vimapi_exec VisWinResize'
  alias ,resize_x='vimapi_exec VisWinVResize'
  alias ,toggle='vimapi_exec VisWinMaximizeYToggleTerm'
  alias ,toggle_x='vimapi_exec VisWinMaximizeXToggleTerm'

  alias ,lg='vimapi_exec VisLazygit tab'
  alias ,man='vimapi_exec VisFzfMan tab'
  alias ,apt='vimapi_exec VisFzfApt tab'
  alias ,pip='vimapi_exec VisFzfPip tab'
  alias ,dpkg='vimapi_exec VisFzfDpkg tab'

  alias ,GS='vimapi_exec VisGS'
  alias ,GV='vimapi_exec VisGV'
  alias ,GL='vimapi_exec_above GitLog $PWD'

  alias ,t=',toggle'
  alias ,tx=',toggle_x'
  alias ,t0=',resize 5'
  alias ,t1=',resize 10'
  alias ,t2=',resize 20'
  alias ,t3=',resize 30'
  alias ,t4=',resize 40'
}

f_alias_term() {
  if [ $MY_OS_NAME = 'gitbash' ]; then
    TERM_cygwin='TERM=cygwin'
  else
    TERM_cygwin=''
  fi
  alias ,I="$TERM_cygwin vim -c 'VisIDE'"
  alias ,I2="$TERM_cygwin vim -c 'VisIDE 2'"
  alias ,T="$TERM_cygwin vim -c 'VisTerm' -c 'only'"
  alias ,T2="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'VisTerm'"
  alias ,T2v="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'vert VisTerm'"

  alias ,nI='nvim -c "VisIDE"'
  alias ,nT='nvim -c "VisTerm" -c "only"'
  alias ,nT2='nvim -c "VisTerm" -c "only" -c "VisTerm"'
  alias ,nT2v='nvim -c "VisTerm" -c "only" -c "vert VisTerm"'

  alias ,GS='vim -c "VisGS"'
  alias ,GV='vim -c "VisGV"'
}

#======================================================
# os
#======================================================
f_alias_wsl() {
  alias ,D='te.sh'
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'
  alias gitbash='gitbash.sh'
}

f_alias_msys() {
  :
}

f_alias_gitbash() {
  alias ,D='te.sh'
}

f_alias_linux() {
  #alias ,D='nautilus'
  #alias ,pdf='evince'
  alias ,D='exo-open --launch FileManager'
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

#------------------------------------------------------
f_alias_common
f_alias_$MY_OS_NAME
if [ "$VIM_TERMINAL" ]; then
  f_alias_vim_term
else
  f_alias_term
fi
