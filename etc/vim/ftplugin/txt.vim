"
" for txt
"
if exists("b:did_ftplugin_txt")
  finish
endif
let b:did_ftplugin_txt = 1

setl tabstop=2
setl shiftwidth=2

nnoremap <buffer> <C-A>  :call MyOpenNERDTree("")<CR>
nnoremap <buffer> <C-N>  :call MyTermSendCd("")<CR>
nnoremap <buffer> <C-O>  :call MyOpenDir("")<CR>
nnoremap <buffer> <C-U>  :call MyOpenURL("")<CR>
nnoremap <buffer> <C-CR> :call MyTermSendCmd("")<CR>

