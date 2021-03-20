"------------------------------------------------------
" dev.func
"------------------------------------------------------
func s:MyIDE()
  NERDTree
  wincmd l
  Tagbar
  MyTerm 0
endfunc

func s:ClangFormat()
  !clang-format -i %
endfunc

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

"------------------------------------------------------
" dev.command
"------------------------------------------------------
command MyIDE              call s:MyIDE()
command ClangFormat        call s:ClangFormat()
command MyEditAltSrc       call s:MyEditAltSrc()
command MyStartProf        call s:MyStartProf()
command MyEndProf          call s:MyEndProf()

