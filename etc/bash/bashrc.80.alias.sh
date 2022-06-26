#!/bin/bash

#======================================================
# alias
#======================================================

# directory stack
alias .='pushd'
alias ..='pushd +2'
alias ...='pushd +3'
alias ,='popd'
alias ,,='popd +1'
alias ,,,='popd +2'
alias ?='dirs -v'
alias .c='dirs -c'
alias .i='dirs -c; cd'

# remap
alias grep='grep -s'
alias nm='nm -C'
alias df='df -h'
alias more='$PAGER'

# shell
alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'
alias lsd='\ls -d --color=auto */'
alias psu='ps -u $USER'
ll() { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -5; }
psall() { ps -aef | grep $*; }
ff() { find . -name "$*" -print; }

# vim
alias vi='vim'
alias vim-zero='/usr/bin/vim -u NONE'
alias vim-min='/usr/bin/vim -u $MY_VIM/vimrc_min.vim'
alias vim-tags='/usr/bin/vim -e -c "helptags . | quit"'
alias nvim-0.7='flatpak run --user io.neovim.nvim -u ~/.vimrc'
vim-which() { vim `which "$1"` $2; }
vim-where() { vim `which "$1"` $2; }

# file
alias f='vifm'
alias f.='vifm -c "OneCol" . ~'
alias f..='vifm -c "TwoCol" . .'

# net
alias wget-page='wget -N -k -p -L -np'
alias wget-page1='wget -N -k -p -L -np -r -l1'
alias wget-page2='wget -N -k -p -L -np -r -l2'
alias wget-local-all='wget -N -k -p -L -np -r --no-proxy'

# misc
alias www='w3m -B'
vid() { display "vid:$*"; }

