#!/bin/bash

#======================================================
# my
#======================================================
#------------------------------------------------------
# vim terminal
#------------------------------------------------------
f_alias_vim_term() {
  alias _ide_toggle_x='vimapi_exec VisWinMaximizeXToggleTerm'
  alias _ide_toggle_y='vimapi_exec VisWinMaximizeYToggleTerm'
  alias _ide_resize_w='vimapi_exec VisWinVResize'
  alias _ide_resize_h='vimapi_exec VisWinResize'

  alias ,rx='_ide_toggle_x'
  alias ,ry='_ide_toggle_y'
  alias ,ry0='_ide_resize_h 5'
  alias ,ry1='_ide_resize_h 10'
  alias ,ry2='_ide_resize_h 20'
  alias ,ry3='_ide_resize_h 30'
  alias ,ry4='_ide_resize_h 40'
  alias ,ry5='_ide_resize_h 50'
  alias ,ry6='_ide_resize_h 60'

  alias ,d='vimapi-edit-dir'
  alias ,d2='vimapi-edit-dir-2'

  alias ,I='vimapi_exec VisIDE'
  alias ,I2='vimapi_exec VisIDE 2'
  alias ,edit='vimapi_exec new'
  alias ,term='vimapi_exec VisTerm'
  alias ,label='vimapi-tabline-set-label'

  alias ,vedit='vimapi_exec vnew'
  alias ,vterm='vimapi_exec VisTermV'

  alias ,gs='cmd.sh f_popup_gs'
  alias ,gg='cmd.sh f_popup_gv'
  alias ,man='cmd.sh f_popup_man'
  alias ,apt='cmd.sh f_popup_apt'

  # alias ,gl='vimapi_exec_above GitLog $PWD'

  alias ,vimdiff='popup-vimdiff.sh'
  alias ,vimdirdiff='popup-vimdirdiff.sh'
  alias ,vimdiff.alt='vimdiff.alt'
  alias ,vimdirdiff.alt='vimdirdiff.alt'

  #------------------------------------------------------
  # tab
  #------------------------------------------------------
  alias ,,I='vimapi_exec_tab VisIDE'
  alias ,,I2='vimapi_exec_tab VisIDE 2'
  alias ,,edit='vimapi_exec tabedit'
  alias ,,term='vimapi_exec tab VisTerm'

  alias ,,gs='vimapi_exec VisGS'
  alias ,,gg='vimapi_exec VisGV'

  alias ,,vimdiff='tab-vimdiff.sh'
  alias ,,vimdirdiff='tab-vimdirdiff.sh'
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
  alias ,I="$TERM_cygwin vim -c 'VisIDE'"
  alias ,I2="$TERM_cygwin vim -c 'VisIDE 2'"
  alias ,term="$TERM_cygwin vim -c 'VisTerm' -c 'only'"
  alias ,term2="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'VisTerm'"
  alias ,term2v="$TERM_cygwin vim -c 'VisTerm' -c 'only' -c 'vert VisTerm'"

  alias ,nI='nvim -c "VisIDE"'
  alias ,nterm='nvim -c "VisTerm" -c "only"'
  alias ,nterm2='nvim -c "VisTerm" -c "only" -c "VisTerm"'
  alias ,nterm2v='nvim -c "VisTerm" -c "only" -c "vert VisTerm"'
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
  alias vim='vim.sh'
  alias ls='ls.sh'
  alias make='mymake.sh'
  alias m='mymake.sh'

  alias vim-which='vim-which.sh'
  alias vim-where='vim-which.sh'

  alias lsg='exa-short.sh'

  alias ,D='open_dir.sh'
  alias ,E='explorer.sh'
  alias ,V='vscode.sh'

  alias ,G.set_dir='mypushd.sh --set `pwd`'
  alias ,G.get_dir='mypushd.sh --get'
  alias ,G.cd='cd `mypushd.sh --get`'
  alias ,G.mv='f_g_mv'
  alias ,G.cp='f_g_cp'
}

#------------------------------------------------------
f_g_mv() { mv "$@" `mypushd.sh --get`; }
f_g_cp() { cp "$@" `mypushd.sh --get`; }

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

