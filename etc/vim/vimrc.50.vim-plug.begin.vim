"======================================================
" vim-plug
"======================================================
set complete=.,w,b,u,i

let s:use_eskk=1
let s:use_gitgutter=1
let s:use_nerdtree_git_plugin=0
let s:use_asyncomplete=1
let s:use_lsp=1
let s:use_lsp_pyls=1
let s:use_lsp_ccls=0
let s:use_lsp_clangd=0
let s:use_lsp_ultisnips=1
let s:use_ultisnips=1
let s:lsp_debug=1
let s:auto_popup=1

let g:fugitive_git_executable=$MY_GIT_EXE

if empty(glob('$MY_VIM/autoload/plug.vim'))
  silent !curl -fLo $MY_VIM/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('$MY_VIM/plugged')

