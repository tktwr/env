"======================================================
" func
"======================================================
func MyGetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

func MyExpand(url)
  let l:url = a:url
  if (l:url == "")
    let l:url = expand("<cfile>")
  endif
  let l:url = expand(l:url)

  if (match(l:url, "http") == 0)
    let l:result = {"type": "http", "url": l:url}
  elseif (isdirectory(l:url))
    let l:result = {"type": "dir", "url": l:url}
  elseif (filereadable(l:url))
    let l:result = {"type": "file", "url": l:url}
  else
    let l:url = expand("%:p")
    let l:result = {"type": "file", "url": l:url}
  endif

  return l:result
endfunc

func MyExpandDir(url)
  let l:result = MyExpand(a:url)
  if (l:result["type"] == "dir")
    let l:dir = l:result["url"]
  elseif (l:result["type"] == "file")
    let l:dir = MyGetDirName(l:result["url"])
  else
    let l:dir = expand("%:p:h")
  endif
  return l:dir
endfunc

func MyRedraw()
  redraw!
  set invnumber
  set invlist
  call quickhl#manual#reset()
  nohlsearch
  let l:dir = getcwd()
  let l:file = expand("%")
  echo "cwd : ".l:dir
  echo "file: ".l:file
  "file
endfunc

