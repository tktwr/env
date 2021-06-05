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

func MyUrlType(url)
  let url = a:url

  if (match(url, 'http\|https') == 0)
    let type = "http"
  elseif (match(url, '^//') == 0)
    let type = "network"
  elseif (match(url, '^\\') == 0)     " difficult to handle this format
    let type = ""
  elseif (isdirectory(url))
    let type = "dir"
  elseif (filereadable(url))
    let type = "file"
  else
    let type = ""
  endif

  return type
endfunc

func MyExpand(url)
  let url = a:url
  if (url == "")
    let url = expand("<cfile>")
  endif
  let url = expand(url)
  let type = MyUrlType(url)
  return {"type": type, "url": url}
endfunc

func MyExpandDir(url)
  let r = MyExpand(a:url)

  if (r.type == "dir")
    let dir = r.url
  elseif (r.type == "file")
    let dir = MyGetDirName(r.url)
  else
    let dir = expand("%:p:h")
  endif

  return dir
endfunc

func MyUnexpand(dir)
  let dir = a:dir
  let dir = substitute(dir, '^'.expand("$MY_PAPERS"), '$MY_PAPERS', "")
  let dir = substitute(dir, '^'.expand("$MY_GIT"), '$MY_GIT', "")
  let dir = substitute(dir, '^'.expand("$MY_WORK"), '$MY_WORK', "")
  let dir = substitute(dir, '^'.expand("$MY_PROJ"), '$MY_PROJ', "")
  let dir = substitute(dir, '^'.expand("$MY_DOC"), '$MY_DOC', "")
  let dir = substitute(dir, '^'.expand("$MY_OFFICE"), '$MY_OFFICE', "")
  let dir = substitute(dir, '^'.expand("$MY_DIARY"), '$MY_DIARY', "")
  let dir = substitute(dir, '^'.expand("$MY_MEMO"), '$MY_MEMO', "")
  let dir = substitute(dir, '^'.expand("$MY_ETC"), '$MY_ETC', "")
  let dir = substitute(dir, '^'.expand("$MY_ENV"), '$MY_ENV', "")
  let dir = substitute(dir, '^'.expand("$MY_REMOTE_CONFIG"), '$MY_REMOTE_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_LOCAL_CONFIG"), '$MY_LOCAL_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_PRIVATE_CONFIG"), '$MY_PRIVATE_CONFIG', "")
  let dir = substitute(dir, '^'.expand("$MY_PRIVATE"), '$MY_PRIVATE', "")
  let dir = substitute(dir, '^'.expand("$MY_PROTECTED"), '$MY_PROTECTED', "")
  let dir = substitute(dir, '^'.expand("$MY_PUBLIC"), '$MY_PUBLIC', "")
  let dir = substitute(dir, '^'.expand("$MY_DESKTOP"), '$MY_DESKTOP', "")
  let dir = substitute(dir, '^'.expand("$MY_DOWNLOADS"), '$MY_DOWNLOADS', "")
  let dir = substitute(dir, '^'.expand("$MY_HOME"), '^', "")
  let dir = substitute(dir, '^'.expand("$HOME"), '~', "")
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

