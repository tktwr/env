"======================================================
" vim-plug
"======================================================
"let plug_file = expand('~/.vim/autoload/plug.vim')
"let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"if empty(glob(plug_file))
"  silent !curl -fLo plug_file --create-dirs plug_url
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('~/.vim/plugged')

"Plug 'Ajnasz/vim-popup-menu'
Plug 'kamykn/popup-menu.nvim'

Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'

Plug 'morhetz/gruvbox'

call plug#end()

"======================================================
" color
"======================================================
colorscheme gruvbox

"======================================================
" map
"======================================================
nnoremap <silent> <End>      <C-W>:silent call wbl#WblPrint()<CR>
tnoremap <silent> <End>      <C-W>:silent call wbl#WblPrint()<CR>

