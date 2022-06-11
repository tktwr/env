"------------------------------------------------------
Plug 'godlygeek/tabular'

command MyTabBar             Tabularize /|
command MyTabColon           Tabularize /:
command MyTabComma           Tabularize /,
command MyTabDots            Tabularize /\.\.\.
command MyTabEqual           Tabularize /=

"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

"------------------------------------------------------
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDMenuMode=0
let g:NERDCreateDefaultMappings=0

"------------------------------------------------------
Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_default_mapping = 0
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_exclude_filetypes = ['help', 'fern', 'nerdtree', 'bmk']

