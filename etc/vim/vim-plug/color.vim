"------------------------------------------------------
" color scheme
"------------------------------------------------------
Plug 'morhetz/gruvbox'
let g:gruvbox_contrast_dark = "soft"

"------------------------------------------------------
Plug 'tomasr/molokai'
"let g:molokai_original = 1
"let g:rehash256 = 1

"------------------------------------------------------
" syntax
"------------------------------------------------------
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'tikhomirov/vim-glsl'

"------------------------------------------------------
" display
"------------------------------------------------------
Plug 'gko/vim-coloresque'

"------------------------------------------------------
" quickhl
"------------------------------------------------------
Plug 't9md/vim-quickhl'
let g:quickhl_manual_colors = [
      \ "cterm=bold ctermfg=255 ctermbg=124 ",
      \ "cterm=bold ctermfg=255 ctermbg=172 ",
      \ "cterm=bold ctermfg=255 ctermbg=112 ",
      \ "cterm=bold ctermfg=255 ctermbg=34  ",
      \ "cterm=bold ctermfg=255 ctermbg=37  ",
      \ "cterm=bold ctermfg=255 ctermbg=27  ",
      \ "cterm=bold ctermfg=255 ctermbg=92  ",
      \ "cterm=bold ctermfg=255 ctermbg=161 ",
      \ ]

"------------------------------------------------------
" indent
"------------------------------------------------------
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'fern', 'nerdtree', 'bmk']

