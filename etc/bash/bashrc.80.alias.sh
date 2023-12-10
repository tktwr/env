#!/bin/bash

#======================================================
# alias
#======================================================

# shell
alias s-zero='source $MY_BASH/bashrc_zero.sh'
alias s='source $HOME/.bashrc'
alias h='history 20'
alias j='jobs -l'
alias where='type -all'

# directory stack
alias ,pu='pushd'
alias ,pu1='pushd +1'
alias ,pu2='pushd +2'
alias ,po='popd'
alias ,po1='popd +1'
alias ,po2='popd +2'
alias ,dl='dirs -v'
alias ,dc='dirs -c'
alias ,di='dirs -c; cd'

# remap
alias sudo='sudo -E'
alias grep='grep -s'
alias nm='nm -C'
alias df='df -h'
alias more='$PAGER'

# ps
alias psu='ps -H -u $USER'
alias psall='ps -aefH'

# ls
alias lsd='\ls -d --color=auto */'
ll() { ls -l --color $* | $PAGER; }
lst() { ls -lt --color $* | grep -v "/$" | head -5; }
alias tree2='tree -L 2'

# find
ff() { find . -name "$*" -print; }

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
vid() { display "vid:$*"; }
