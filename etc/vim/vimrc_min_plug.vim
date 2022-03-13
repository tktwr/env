
call plug#begin('~/.vim/plugged')

Plug 'tktwr/vim-winbuf-menu'

call plug#end()

nnoremap <silent> <End>      <C-W>:silent call WblPrint()<CR>
tnoremap <silent> <End>      <C-W>:silent call WblPrint()<CR>

