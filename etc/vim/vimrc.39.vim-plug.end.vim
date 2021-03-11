call plug#end()

func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-python coc-clangd coc-snippets coc-lists
endfunc

command MyCocInstall     call s:MyCocInstall()

"------------------------------------------------------
" colorscheme
"------------------------------------------------------
colorscheme gruvbox

