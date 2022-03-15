
call plug#begin('~/.vim/plugged')

"Plug 'Ajnasz/vim-popup-menu'
Plug 'kamykn/popup-menu.nvim'
Plug 'tktwr/vim-winbuf-menu'

call plug#end()

nnoremap <silent> <End>      <C-W>:silent call WblPrint()<CR>
tnoremap <silent> <End>      <C-W>:silent call WblPrint()<CR>

