"------------------------------------------------------
"Plug 'itchyny/vim-qfedit'
Plug 'thinca/vim-qfreplace'

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

"======================================================
" comment
"======================================================
Plug 'tomtom/tcomment_vim'

if !exists('g:tcomment_types')
	let g:tcomment_types = {}
endif
let g:tcomment_types['txt'] = '# %s'
"------------------------------------------------------
"Plug 'tpope/vim-commentary'
"------------------------------------------------------
"Plug 'scrooloose/nerdcommenter'
"let g:NERDDefaultAlign='left'
"let g:NERDMenuMode=0
"let g:NERDCreateDefaultMappings=0

