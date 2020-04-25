"
" for sh
"
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setl tabstop=2
setl shiftwidth=2

" abbrebiations
iabclear
iabbr IF    if []; then<CR>fi<ESC>-f]i
iabbr ELIF  elif []; then<ESC>F]i
iabbr EL    else
iabbr FOR   for i in; do<CR>done<ESC>-f;i
iabbr WH    while []; do<CR>done<ESC>-f]i
iabbr SW    case in<CR>*) ;;<CR>esac<ESC>2-ea
iabbr COM    ###########################################################################<CR>#<CR>#<CR>#<CR>###########################################################################<ESC>2kA

