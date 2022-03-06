"------------------------------------------------------
" func
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
" command
"------------------------------------------------------
command MyTrans            call s:MyTrans()
command MyDict             call s:MyDict()

command MyClangFormat      call s:MyClangFormat()

command RunExplorer        silent !explorer.sh %:h
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"
command RunGvim            silent !gvim "%"

