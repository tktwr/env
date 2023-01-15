Plug 'majutsushi/tagbar'

let universal_ctags = '/mingw64/bin/ctags.exe'
if filereadable(universal_ctags)
  let g:tagbar_ctags_bin = universal_ctags
endif
let g:tagbar_width = g:my_right_winwidth
let g:tagbar_iconchars = ['+', '-']
let g:tagbar_sort = 0

