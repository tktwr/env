"------------------------------------------------------
" edit.func
"------------------------------------------------------
" remove a linefeed NL (0x0A)
func s:RemoveNL(str)
  return substitute(a:str, "[\xA]$", '', '')
endfunc

func s:MySystem(str)
  return s:RemoveNL(system(a:str))
endfunc

func s:MyTogglePathFormat()
  let l:path = getline('.')
  let l:ch = l:path[col('.')-1]

  if (!(l:ch == '\' || l:ch == '/'))
    let l:nr = match(l:path, '[\/]')
    if (l:nr != -1)
      let l:ch = l:path[l:nr]
    else
      let l:ch = '\'
    endif
  endif

  if (l:ch == '\')
    let l:str = substitute(l:path, '\', '/', 'g')
  elseif (l:ch == '/')
    let l:str = substitute(l:path, '/', '\', 'g')
  else
    let l:str = l:path
  endif

  call setline('.', l:str)
endfunc

" update the line started with "[LastChange]"
func s:MyUpdateLastChange()
  normal m'
  let l:nr = search('\[LastChange\]')
  if (l:nr != 0)
    let l:cmd = "env LC_TIME=C date"
    let l:str = s:MySystem(l:cmd)
    call setline('.', "[LastChange] ".l:str)
  endif
  normal `'
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

func s:MyMakeLink(prefix)
  let l:start = line('.')
  let l:end = l:start + 1
  let l:line = getline(start, end)
  let l:str = a:prefix.'['.l:line[0].']('.l:line[1].')'
  call setline('.', l:str)
  execute l:end 'delete _'
endfunc

"------------------------------------------------------
" edit.command
"------------------------------------------------------
command MyTogglePathFormat       call s:MyTogglePathFormat()
command MyUpdateLastChange       call s:MyUpdateLastChange()
command MyAddTime                call s:MyAddTime()
command -nargs=? MyAddDate       call s:MyAddDate("<args>")
command MyUpdateDateHere         call s:MyAddDate(expand("<cWORD>"))

command MyMakeLink               call s:MyMakeLink('- ')
command MyMakeImageLink          call s:MyMakeLink('!')

"------------------------------------------------------
" edit.autocmd
"------------------------------------------------------
autocmd BufWritePre,FileWritePre *.html  MyUpdateLastChange
autocmd BufWritePre,FileWritePre *.txt   MyUpdateLastChange

