"------------------------------------------------------
" dev
"------------------------------------------------------

func s:AfterH()
  let header_id = substitute(expand("%:t"), "\\.", "_", "")
  silent exec "%s/HEADER_ID/".header_id."/"
endfunc
command AfterH call s:AfterH()

func s:EditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cxx"
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
    nnoremap <C-P>   [c
    nnoremap <C-N>   ]c
  endif
endfunc
autocmd VimEnter,FilterWritePre * call s:SetDiffMode()

