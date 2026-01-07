#!/bin/bash

#======================================================
# alias
#======================================================
_f_g_mv() { mv "$@" `mypushd.sh --get`; }
_f_g_cp() { cp "$@" `mypushd.sh --get`; }

ll()  { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -5; }
ff()  { find . -name "$*" -print; }
vid() { display "vid:$*"; }

f_alias() {
  # source
  alias s='source $HOME/.bashrc'
  alias s.venv='source .venv/bin/activate'
  alias s.zero='source $MY_BASH/bashrc_zero.sh'

  # shell
  alias h='history 20'
  alias j='jobs -l'
  alias where='type -all'

  # remap
  alias sudo='sudo -E'
  alias grep='grep -s'
  alias nm='nm -C'
  alias df='df -h'
  alias more='$PAGER'
  alias fd='fdfind'

  # ps
  alias psu='ps -H -u $USER'
  alias psall='ps -aefH'

  # ls
  alias lsd='\ls -d --color=auto */'
  alias tree2='tree -L 2'

  # python
  alias p='python'

  # vim
  alias vi='vim'
  alias vim-none='/usr/bin/vim -u NONE'
  alias vim-zero='/usr/bin/vim -u $MY_VIM/vimrc_zero.vim'
  alias vim-test-plug='/usr/bin/vim -u $MY_VIM/vimrc_test_plug.vim'

  # vifm
  alias vf='vifm'
  alias vf.='vifm -c "OneCol" . ~'
  alias vf..='vifm -c "TwoCol" . .'

  # net
  alias wget-page='wget -N -k -p -L -np'
  alias wget-page1='wget -N -k -p -L -np -r -l1'
  alias wget-page2='wget -N -k -p -L -np -r -l2'
  alias wget-local-all='wget -N -k -p -L -np -r --no-proxy'

  # misc
  alias www='w3m -B'
}

f_alias_git() {
  alias ,g='git-default.sh'

  alias ,gs='$SYS_GIT_EXE status'
  alias ,gS='$SYS_GIT_EXE status -s'
  alias ,gd='$SYS_GIT_EXE diff'
  alias ,gD='$SYS_GIT_EXE diff --staged'
  alias ,gf='$SYS_GIT_EXE fetch'
  alias ,gg='$SYS_GIT_EXE graph'
  alias ,gb='$SYS_GIT_EXE branch'
  alias ,gt='$SYS_GIT_EXE tag'

  alias ,ga='$SYS_GIT_EXE add'
  alias ,gau='$SYS_GIT_EXE add -u'
  alias ,gac='cmd.sh f_git_commit_add'
  alias ,gc='cmd.sh f_git_commit'

  alias ,gR='$SYS_GIT_EXE reset --hard'
  alias ,gRom='cmd.sh f_git_reset_hard_origin'
  alias ,gPom='cmd.sh f_git_push_origin'

  alias ,G='$SYS_GIT_EXE graph --date-order -6'
  alias ,GA='$SYS_GIT_EXE graph --date-order -6 --all'
  alias ,GM='git-log.sh --log 4 --log-submodule 2'

  alias ,gba='cmd.sh f_git_print_branch_all'
  alias ,gta='cmd.sh f_git_print_tag_all'

  alias cd.root='cd $(cmd.sh f_git_root)'
  alias pd.root='pushd $(cmd.sh f_git_root)'
}

f_alias_fzf() {
  alias ,='eval_bmk       $(fzf_bmk.sh bmk_dir.txt bmk_dir_opt.txt tcmd.txt tcmd_sys.txt bmk_file.txt bmk_file_opt.txt links.txt papers.txt)'
  alias ,c='eval_fzf_cmd  cmd.sh'
  alias ,m='eval_fzf_cmd  mymake.sh'
  alias ,fd='eval_fzf_fd'
  alias ,rg='eval_fzf_rg'

  alias .='pushd'
  alias ..='pushd .'
  alias ,,='eval_cmd      pushd $(fzf_pushd)'
  alias ,,,='popd'
  alias ,-='eval_cmd      popd  $(fzf_pushd)'
  alias ,--='dirs -c'
  #alias ..='eval_cmd     pushd $(fzf_bmk.sh bmk_dir.txt bmk_dir_opt.txt | bmk_get_value)'
}

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

  alias ,vert.edit='vimapi_exec vnew'
  alias ,vert.term='vimapi_exec VisTermV'

  # alias ,gl='vimapi_exec_above GitLog $PWD'

  #------------------------------------------------------
  # cmd.sh
  #------------------------------------------------------
  alias ,eu='cmd.sh f_envs_ci_summary'

  alias ,gu='cmd.sh f_git_ci_summary'
  alias ,gi='cmd.sh f_git_ci_info'

  #------------------------------------------------------
  # popup
  #------------------------------------------------------
  alias .gs='cmd.sh f_popup_gs'
  alias .gg='cmd.sh f_popup_gv'
  alias .man='cmd.sh f_popup_man'
  alias .apt='cmd.sh f_popup_apt'

  alias .vimdiff='popup-vimdiff.sh'
  alias .vimdirdiff='popup-vimdirdiff.sh'
  alias .vimdiff.alt='vimdiff.alt'
  alias .vimdirdiff.alt='vimdirdiff.alt'

  #------------------------------------------------------
  # tab
  #------------------------------------------------------
  alias ..I='vimapi_exec_tab VisIDE'
  alias ..I2='vimapi_exec_tab VisIDE 2'
  alias ..edit='vimapi_exec tabedit'
  alias ..term='vimapi_exec tab VisTerm'

  alias ..GS='vimapi_exec VisGS'
  alias ..GG='vimapi_exec VisGV'

  alias ..vimdiff='tab-vimdiff.sh'
  alias ..vimdirdiff='tab-vimdirdiff.sh'
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

  alias ,w.dir='open_dir.sh'
  alias ,w.exp='explorer.sh'
  alias ,w.vscode='vscode.sh'

  alias ,t.set_dir='mypushd.sh --set `pwd`'
  alias ,t.get_dir='mypushd.sh --get'
  alias ,t.cd='cd `mypushd.sh --get`'
  alias ,t.mv='_f_g_mv'
  alias ,t.cp='_f_g_cp'
}

#------------------------------------------------------
my_setup_alias() {
  f_alias
  f_alias_git
  f_alias_fzf
  f_alias_os_common
  f_alias_os_$MY_OS_NAME
  if [ "$VIM_TERMINAL" ]; then
    f_alias_vim_term
  else
    f_alias_term
  fi
}

