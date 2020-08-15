"======================================================
" minimal vimrc
"======================================================

set nocompatible

set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,cp936

set noswapfile
set nobackup
set noundofile

set background=dark

" IM off for start up
set iminsert=0
set imsearch=-1
inoremap <ESC> <ESC>:set iminsert=0<CR>

nnoremap Q     :confirm qall<CR>

