"======================================================
" minimal vimrc
"======================================================
"let $MY_VIM = expand('~/.vim')

"------------------------------------------------------
" basic
"------------------------------------------------------
set nocompatible

set hidden
set autowrite
set noswapfile
set nobackup
set nowritebackup
set noundofile

set updatetime=300
set timeoutlen=300

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936

set viminfo=

"------------------------------------------------------
" color
"------------------------------------------------------
set termguicolors
set t_Co=256
set background=dark

"------------------------------------------------------
" map
"------------------------------------------------------
nnoremap Q       :confirm qall<CR>
nnoremap '       `

nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

tnoremap <C-H>   <C-W>h
tnoremap <C-J>   <C-W>w
tnoremap <C-K>   <C-W>W
tnoremap <C-L>   <C-W>l

nnoremap <C-D>   <C-B>
nnoremap <C-E>   :close<CR>
nnoremap <C-G>   <C-L>

nnoremap ,p      "*p
vnoremap Y       "*y

