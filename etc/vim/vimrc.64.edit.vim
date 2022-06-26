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

"------------------------------------------------------
func s:EditMdLinkCommon(prefix)
  let start = line('.')
  let end = start + 1
  let line = getline(start, end)
  let str = printf("%s[%s](%s)", a:prefix, line[0], line[1])
  call setline('.', str)
  execute end 'delete _'
endfunc

func EditMdLink()
  call s:EditMdLinkCommon('- ')
endfunc

func EditMdImgLink()
  call s:EditMdLinkCommon('!')
endfunc

func EditHtmlLink()
  let start = line('.')
  let end = start + 1
  let line = getline(start, end)
  let str = printf('<a href="%s">%s</a>', line[1], line[0])
  call setline('.', str)
  execute end 'delete _'
endfunc

func EditHtmlImgLink()
  let start = line('.')
  let end = start + 1
  let line = getline(start, end)
  let str = printf('<img src="%s">%s</img>', line[1], line[0])
  call setline('.', str)
  execute end 'delete _'
endfunc

func EditBmkLink()
  let start = line('.')
  let end = start + 1
  let line = getline(start, end)
  let str = printf("-   %s | %s", line[0], line[1])
  call setline('.', str)
  execute end 'delete _'
endfunc

func EditTogglePathFormat()
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

"------------------------------------------------------
" edit.command
"------------------------------------------------------
command MyUpdateLastChange       call s:MyUpdateLastChange()
command MyAddTime                call s:MyAddTime()
command -nargs=? MyAddDate       call s:MyAddDate(<f-args>)
command MyUpdateDateHere         call s:MyAddDate(expand("<cWORD>"))

"------------------------------------------------------
" edit.autocmd
"------------------------------------------------------
augroup ag_my_edit
  autocmd!
  autocmd BufWritePre,FileWritePre *.html  MyUpdateLastChange
  autocmd BufWritePre,FileWritePre *.txt   MyUpdateLastChange
augroup END

