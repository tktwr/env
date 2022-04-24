"======================================================
" vim-plug
"======================================================
"let plug_file = expand('$MY_VIM/autoload/plug.vim')
"let plug_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"if empty(glob(plug_file))
"  silent !curl -fLo plug_file --create-dirs plug_url
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

call plug#begin('$MY_VIM/plugged')

" fern
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'

if has('nvim')
  " popup for nvim
  "Plug 'Ajnasz/vim-popup-menu'
  Plug 'kamykn/popup-menu.nvim'
endif

" ide
Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'

" color
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

call plug#end()

"======================================================
" color
"======================================================
colorscheme gruvbox

"======================================================
" map
"======================================================
nnoremap <silent> <End>      <C-W>:call wbl#WblPrint()<CR>
tnoremap <silent> <End>      <C-W>:call wbl#WblPrint()<CR>

nnoremap <silent> <Space>    <C-W>:CpmOpen<CR>
tnoremap <silent> <C-Space>  <C-W>:CpmOpen<CR>

