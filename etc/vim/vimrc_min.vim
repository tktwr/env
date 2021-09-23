"======================================================
" minimal vimrc
"======================================================

set nocompatible

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936

set noswapfile
set nobackup
set noundofile
set viminfo=

set background=dark

nnoremap Q       :confirm qall<CR>
nnoremap '       `

nnoremap <C-H>   <C-W>h
nnoremap <C-J>   <C-W>w
nnoremap <C-K>   <C-W>W
nnoremap <C-L>   <C-W>l

nnoremap <C-D>   <C-B>
nnoremap <C-E>   :close<CR>
nnoremap <C-G>   <C-L>

nnoremap ,p      "*p
vnoremap Y       "*y

