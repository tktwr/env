"======================================================
" vim-plug
"======================================================
set complete=.,w,b,u,i

let s:use_eskk=0
let s:use_gitgutter=1
let s:use_nerdtree_git_plugin=0

if empty(glob('$MY_VIM/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$MY_VIM/plugged')

