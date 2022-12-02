"------------------------------------------------------
" external
"------------------------------------------------------
" remove a linefeed NL (0x0A)
func s:RemoveNL(str)
  return substitute(a:str, "[\xA]$", '', '')
endfunc

func s:MySystem(str)
  return s:RemoveNL(system(a:str))
endfunc

func s:MyAddTime()
  let l:cmd = "env LC_TIME=C date '+%T'"
  let l:str = s:MySystem(l:cmd)
  call setline('.', l:str)
endfunc

func s:MyAddDate(date)
  let l:cmd = "env LC_TIME=C date --date='".a:date."' '+%Y/%m/%d (%a)'"
  let l:str = s:MySystem(l:cmd)
  call setline('.', l:str)
endfunc

"------------------------------------------------------
func s:MyTrans()
  exec "below term ++rows=".g:my_trans_winheight." trans -I -b"
endfunc

func s:MyDict()
  exec "below term ++rows=".g:my_trans_winheight." ++close trans -I"
endfunc

func s:MyClangFormat()
  !clang-format -i %
endfunc

"------------------------------------------------------
command MyAddTime                call s:MyAddTime()
command -nargs=? MyAddDate       call s:MyAddDate(<f-args>)
command MyUpdateDateHere         call s:MyAddDate(expand("<cWORD>"))

command MyTrans                  call s:MyTrans()
command MyDict                   call s:MyDict()
command MyClangFormat            call s:MyClangFormat()

