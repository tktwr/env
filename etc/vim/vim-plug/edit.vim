"------------------------------------------------------
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

"------------------------------------------------------
Plug 'godlygeek/tabular'

command EditTabBar             Tabularize /|
command EditTabColon           Tabularize /:
command EditTabComma           Tabularize /,
command EditTabDots            Tabularize /\.\.\.
command EditTabEqual           Tabularize /=

"------------------------------------------------------
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign='left'
let g:NERDMenuMode=0
let g:NERDCreateDefaultMappings=0

