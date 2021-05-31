"------------------------------------------------------
" external
"------------------------------------------------------
func MyOpenURL(url)
  exec "silent !chrome.sh" a:url
  redraw!
endfunc

func MyOpenDir(url)
  exec "silent !explorer.sh" a:url
  redraw!
endfunc

func MyOpen(url)
  let r = MyExpand(a:url)

  if (r["type"] == "http")
    call MyOpenURL(r["url"])
  elseif (r["type"] == "dir")
    call MyOpenDir(r["url"])
  elseif (r["type"] == "file")
    call MyOpenURL(r["url"])
  endif
endfunc

func MyOpenDirInTerm(winnr, dir)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  if &buftype == 'terminal'
    exec "lcd" a:dir
    let bufnr = winbufnr(0)
    call term_sendkeys(bufnr, "cd ".a:dir."\<CR>")
  endif
endfunc

func MyEditFile(winnr, file)
  if a:winnr > 0
    exec a:winnr."wincmd w"
  endif

  let dir = MyGetDirName(a:file)
  exec "lcd" dir
  exec "edit" a:file
endfunc

func MyEdit(winnr, url)
  let r = MyExpand(a:url)
  let selected = r["url"]

  if (isdirectory(selected))
    call MyOpenDirInTerm(a:winnr, selected)
  elseif (filereadable(selected))
    call MyEditFile(a:winnr, selected)
  endif
endfunc

"------------------------------------------------------
" func
"------------------------------------------------------
func s:MyMemo(...)
  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above Memo"
  else
    exec "above Memo" a:1
  endif

  wincmd p
  close
endfunc

func s:MyHelp(...)
  if &filetype == "help"
    let close_origwin=0
  else
    let close_origwin=1
  endif

  exec "vertical resize" g:my_help_winwidth
  if a:0 == 0
    exec "above help"
  else
    exec "above help" a:1
  endif

  if close_origwin
    wincmd p
    close
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
command -nargs=? MyMemo    call s:MyMemo(<f-args>)
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

