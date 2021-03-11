"------------------------------------------------------
" diff
"------------------------------------------------------
set diffopt=filler,vertical,iwhite

"------------------------------------------------------
" diff.func
"------------------------------------------------------
func s:MySetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc

"------------------------------------------------------
" diff.autocmd
"------------------------------------------------------
au VimEnter,FilterWritePre * call s:MySetDiffMode()

