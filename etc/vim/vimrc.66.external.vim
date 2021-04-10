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
  let l:result = MyExpand(a:url)

  if (l:result["type"] == "http")
    call MyOpenURL(l:result["url"])
  elseif (l:result["type"] == "dir")
    call MyOpenDir(l:result["url"])
  elseif (l:result["type"] == "file")
    call MyOpenURL(l:result["url"])
  endif
endfunc

func MyEdit(url)
  let l:result = MyExpand(a:url)
  exec "edit" l:result["url"]
endfunc

func s:ClangFormat()
  !clang-format -i %
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command ClangFormat        call s:ClangFormat()

command RunExplorer        silent !explorer.exe %:h
command RunGvim            silent !gvim "%"
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"

