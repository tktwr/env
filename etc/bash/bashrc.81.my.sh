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
if [ "$VIM_TERMINAL" ]; then
  alias ,GL='vimapi_exec_above GitLog $PWD'
  alias ,t=',toggle'
  alias ,tx=',toggle_x'
  alias ,t0=',resize 5'
  alias ,t1=',resize 10'
  alias ,t2=',resize 20'
  alias ,t3=',resize 30'
  alias ,t4=',resize 40'
fi

#======================================================
# os
#======================================================
f_alias_wsl() {
  alias D='te.sh'
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'
  alias gitbash='gitbash.sh'
}

f_alias_msys() {
}

f_alias_gitbash() {
  alias D='te.sh'
}

f_alias_linux() {
  #alias D='nautilus'
  #alias p='evince'
  alias D='exo-open --launch FileManager'
  alias p='qpdfview --unique'
  alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
}

f_alias_termux() {
  :
}

f_alias_$MY_OS_NAME
