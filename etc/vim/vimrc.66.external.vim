"------------------------------------------------------
" func
"------------------------------------------------------
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
  let help_winnr = winnr()

  if !start_from_help_win
    wincmd p
    call WblCopy()
    close
    exec help_winnr."wincmd w"
    call WblPaste()
  endif
endfunc

func s:MyMan(word)
  exec "vertical resize" g:my_help_winwidth
  if &filetype == "ref-man"
    exec "above Ref man" a:word
  else
    exec "above Ref man" a:word
    wincmd p
    close
  endif
endfunc

func s:MyPydoc(word)
  exec "vertical resize" g:my_help_winwidth
  if &filetype == "ref-pydoc"
    exec "above Ref pydoc" a:word
  else
    exec "above Ref pydoc" a:word
    wincmd p
    close
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
command -nargs=1 MyMan     call s:MyMan(<f-args>)
command -nargs=1 MyPydoc   call s:MyPydoc(<f-args>)

command MyTrans            call s:MyTrans()
command MyDict             call s:MyDict()

command MyClangFormat      call s:MyClangFormat()

command RunExplorer        silent !explorer.sh %:h
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"
command RunGvim            silent !gvim "%"

