"======================================================
" minimal vimrc
"======================================================
if !exists('$MY_VIM')
  let $MY_VIM = expand('~/.vim')
endif

if has('win32') || has('win64')
  if exists('$MY_VIM_WIN')
    let $MY_VIM = expand('$MY_VIM_WIN')
  endif
endif

set runtimepath-=~/.vim
set runtimepath-=~/.vim/after
set runtimepath^=$MY_VIM
set runtimepath+=$MY_VIM/after
"------------------------------------------------------
" basic
"------------------------------------------------------
set nocompatible
set timeoutlen=300
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936
"------------------------------------------------------
" buffer
"------------------------------------------------------
set hidden
set autowrite
set noswapfile
set nobackup
set nowritebackup
set noundofile
set viminfo=
"------------------------------------------------------
" indent
"------------------------------------------------------
set tabstop=2
set shiftwidth=2
set expandtab
"------------------------------------------------------
" term
"------------------------------------------------------
if &term =~ "xterm"
  set mouse=a
  set ttymouse=xterm2
endif
"------------------------------------------------------
" color
"------------------------------------------------------
set termguicolors
set t_Co=256
set background=dark
set hlsearch
syntax on
"======================================================
" map
"======================================================
nnoremap Q       :confirm qall<CR>
nnoremap '       `
"------------------------------------------------------
" nmap
"------------------------------------------------------
nnoremap <C-D>   <C-B>
nnoremap <C-E>   :close<CR>
nnoremap <C-G>   <C-L>
nnoremap <C-;>   <C-W>:
nnoremap <C-.>   :exec "lcd" expand("%:p:h")<CR>
"------------------------------------------------------
" tmap
"------------------------------------------------------
tnoremap <C-G>   <C-L>
tnoremap <C-O>   <C-W>N
tnoremap <C-;>   <C-W>:
tnoremap <ScrollWheelUp>  <C-W>N<ScrollWheelUp>
"------------------------------------------------------
" map: window
"------------------------------------------------------
nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>w
tnoremap <C-K>   <C-W>W
tnoremap <C-L>   <C-W>l
"------------------------------------------------------
" map: tab
"------------------------------------------------------
nnoremap <silent> <Insert>   <C-W>:tabedit<CR>
nnoremap <silent> <Del>      <C-W>:tabclose<CR>
nnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
nnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>

tnoremap <silent> <Insert>   <C-W>:tabedit<CR>
tnoremap <silent> <Del>      <C-W>:tabclose<CR>
tnoremap <silent> <PageUp>   <C-W>:tabprev<CR>
tnoremap <silent> <S-PageUp> <C-W>:tabnext<CR>
"------------------------------------------------------
" map: clipboard
"------------------------------------------------------
nnoremap ,p      "*p
vnoremap Y       "*y
"======================================================
" nvim
"======================================================
if has('nvim')
tnoremap <C-H>   <C-\><C-N><C-W>h
tnoremap <C-J>   <C-\><C-N><C-W>w
tnoremap <C-K>   <C-\><C-N><C-W>W
tnoremap <C-L>   <C-\><C-N><C-W>l

tnoremap <C-O>   <C-\><C-N>
endif
