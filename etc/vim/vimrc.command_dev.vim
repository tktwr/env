"------------------------------------------------------
" dev
"------------------------------------------------------

func s:EditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cpp"
  endif
  exec "edit" fname
endf
command EditAltSrc call s:EditAltSrc()

"------------------------------------------------------
" diff
"------------------------------------------------------

set diffopt=filler,vertical,iwhite
func s:SetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc
autocmd VimEnter,FilterWritePre * call s:SetDiffMode()

