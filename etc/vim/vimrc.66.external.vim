"------------------------------------------------------
" func
"------------------------------------------------------
func s:MyClosePrevWin()
  let curr_winnr = winnr()
  wincmd p
  call WblCopy()
  close
  exec curr_winnr."wincmd w"
  call WblPaste()
endfunc

func s:MyHelp(...)
  if &filetype == "help"
    let start_from_help_win=1
  else
    let start_from_help_win=0
  endif

  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif

  if !start_from_help_win
    call s:MyClosePrevWin()
  endif
endfunc

func s:MyRef(cmd, word)
  let word = a:word
  if word == "?"
    let word = input("word? ")
  endif
  if word == ""
    echo "canceled"
    return
  endif

  exec "vertical resize" g:my_help_winwidth
  if &filetype =~ "ref-*"
    exec "above Ref" a:cmd word
  else
    exec "above Ref" a:cmd word
    call s:MyClosePrevWin()
  endif
endfunc

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
command -nargs=? MyHelp    call s:MyHelp(<f-args>)
command -nargs=+ MyMan     call s:MyRef("man", <q-args>)
command -nargs=+ MyPydoc   call s:MyRef("pydoc", <q-args>)

command MyTrans            call s:MyTrans()
command MyDict             call s:MyDict()

command MyClangFormat      call s:MyClangFormat()

command RunExplorer        silent !explorer.sh %:h
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"
command RunGvim            silent !gvim "%"

