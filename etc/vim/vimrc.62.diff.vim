"------------------------------------------------------
" diff
"------------------------------------------------------
set diffopt=filler,vertical,iwhite

func s:MySetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc

au VimEnter,FilterWritePre * call s:MySetDiffMode()

