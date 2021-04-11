"======================================================
" func
"======================================================
func MyGetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

func MyCleanLine(line)
  let line = a:line
  let line = substitute(line, '^\s*', '', '')
  let line = substitute(line, '^-\s*', '', '')
  return line
endfunc

func MyGetKeyFnameHere()
  let line = getline('.')
  let line = MyCleanLine(line)
  return MyGetKeyFname(line)
endfunc

func MyGetKeyFname(line)
  let line = a:line
  let mx = '\(\f\+\)\s*|\s*\(\f\+\)'
  let line = matchstr(line, mx)
  let key = substitute(line, mx, '\1', '')
  let fname = substitute(line, mx, '\2', '')
  let result = {"key": key, "fname": fname}
  return result
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

func MyUnexpand(dir)
  let dir = a:dir
  let dir = substitute(dir, expand("$MY_PAPERS"), '$MY_PAPERS', "")
  let dir = substitute(dir, expand("$MY_GIT"), '$MY_GIT', "")
  let dir = substitute(dir, expand("$MY_WORK"), '$MY_WORK', "")
  let dir = substitute(dir, expand("$MY_PROJ"), '$MY_PROJ', "")
  let dir = substitute(dir, expand("$MY_DOC"), '$MY_DOC', "")
  let dir = substitute(dir, expand("$MY_OFFICE"), '$MY_OFFICE', "")
  let dir = substitute(dir, expand("$MY_DIARY"), '$MY_DIARY', "")
  let dir = substitute(dir, expand("$MY_MEMO"), '$MY_MEMO', "")
  let dir = substitute(dir, expand("$MY_ETC"), '$MY_ETC', "")
  let dir = substitute(dir, expand("$MY_ENV"), '$MY_ENV', "")
  let dir = substitute(dir, expand("$MY_REMOTE_CONFIG"), '$MY_REMOTE_CONFIG', "")
  let dir = substitute(dir, expand("$MY_LOCAL_CONFIG"), '$MY_LOCAL_CONFIG', "")
  let dir = substitute(dir, expand("$MY_PRIVATE_CONFIG"), '$MY_PRIVATE_CONFIG', "")
  let dir = substitute(dir, expand("$MY_PRIVATE"), '$MY_PRIVATE', "")
  let dir = substitute(dir, expand("$MY_PROTECTED"), '$MY_PROTECTED', "")
  let dir = substitute(dir, expand("$MY_PUBLIC"), '$MY_PUBLIC', "")
  let dir = substitute(dir, expand("$MY_DESKTOP"), '$MY_DESKTOP', "")
  let dir = substitute(dir, expand("$MY_DOWNLOADS"), '$MY_DOWNLOADS', "")
  let dir = substitute(dir, expand("$MY_HOME"), '^', "")
  let dir = substitute(dir, expand("$HOME"), '~', "")
  return dir
endfunc

func MyCWD()
  if haslocaldir() == 1
    let l:type = "local"
    let l:cwd = getcwd()
  elseif haslocaldir() == 2
    let l:type = "tab"
    let l:cwd = getcwd(-1, 0)
  else
    let l:type = "global"
    let l:cwd = getcwd(-1)
  endif
  let l:cwd = MyUnexpand(l:cwd)
  return "[".l:type.":".l:cwd."]"
endfunc

