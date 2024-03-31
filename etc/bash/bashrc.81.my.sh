#!/bin/bash

#======================================================
# my
#======================================================
#------------------------------------------------------
# vim terminal
#------------------------------------------------------
f_alias_vim_term() {
  alias ,resize='vimapi_exec VisWinResize'
  alias ,resize_x='vimapi_exec VisWinVResize'
  alias ,toggle='vimapi_exec VisWinMaximizeYToggleTerm'
  alias ,toggle_x='vimapi_exec VisWinMaximizeXToggleTerm'

  alias ,r=',toggle'
  alias ,r0=',resize 5'
  alias ,r1=',resize 10'
  alias ,r2=',resize 20'
  alias ,r3=',resize 30'
  alias ,r4=',resize 40'
  alias ,rx=',toggle_x'

  alias ,d='vimapi-edit-dir'
  alias ,d2='vimapi-edit-dir-2'

  alias ,ide='vimapi_exec VisIDE'
  alias ,ide2='vimapi_exec VisIDE 2'
  alias ,edit='vimapi_exec new'
  alias ,term='vimapi_exec VisTerm'

  alias ,vedit='vimapi_exec vnew'
  alias ,vterm='vimapi_exec VisTermV'

  alias ,gs='cmd.sh f_popup_gs'
  alias ,gg='cmd.sh f_popup_gv'

  # alias ,gl='vimapi_exec_above GitLog $PWD'

  #------------------------------------------------------
  # tab
  #------------------------------------------------------
  alias ,,ide='vimapi_exec_tab VisIDE'
  alias ,,ide2='vimapi_exec_tab VisIDE 2'
  alias ,,edit='vimapi_exec tabedit'
  alias ,,term='vimapi_exec tab VisTerm'

  alias ,,gs='vimapi_exec VisGS'
  alias ,,gg='vimapi_exec VisGV'
}

#------------------------------------------------------
# terminal
#------------------------------------------------------
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

#------------------------------------------------------
# os
#------------------------------------------------------
f_alias_os_wsl() {
  alias gvim='gvim.sh'
  alias gvimdiff='gvim.sh -d'
  alias gitbash='gitbash.sh'
}

f_alias_os_msys() {
  :
}

f_alias_os_gitbash() {
  :
}

f_alias_os_linux() {
  alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
}

f_alias_os_termux() {
  :
}

f_alias_os_common() {
  alias ,D='open_dir.sh'
  alias ,E='explorer.sh'

  alias vim='vim.sh'
  alias ls='ls.sh'
  alias make='mymake.sh'
  alias m='mymake.sh'

  alias vimdiff='vimdiff.sh'
  alias vimdirdiff='vimdirdiff.sh'
  alias vim-which='vim-which.sh'
  alias vim-where='vim-which.sh'

  alias lsg='exa-short.sh'

  alias set.G='mypushd.sh --set `pwd`'
  alias get.G='mypushd.sh --get'
  alias cd.G='cd `mypushd.sh --get`'
  alias mv.G='f_mv_g_dir'
  alias cp.G='f_cp_g_dir'
}

#------------------------------------------------------
f_mv_g_dir() { mv "$@" `mypushd.sh --get`; }
f_cp_g_dir() { cp "$@" `mypushd.sh --get`; }

#------------------------------------------------------
my_setup_alias() {
  f_alias
  f_alias_os_common
  f_alias_os_$MY_OS_NAME
  if [ "$VIM_TERMINAL" ]; then
    f_alias_vim_term
  else
    f_alias_term
  fi
}

