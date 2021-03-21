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

