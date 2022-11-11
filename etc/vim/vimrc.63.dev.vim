"------------------------------------------------------
" dev.func
"------------------------------------------------------
func s:MyEditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cpp"
  endif
  exec "edit" fname
endfunc

func s:MyStartProf()
  profile start prof.txt
  profile func *
  profile file *
endfunc

func s:MyEndProf()
  profile pause
  noautocmd qall!
endfunc

func YankFilePath()
  let @@ = expand('%:p')
endfunc

"------------------------------------------------------
" dev.command
"------------------------------------------------------
command MyEditAltSrc       call s:MyEditAltSrc()
command MyStartProf        call s:MyStartProf()
command MyEndProf          call s:MyEndProf()

