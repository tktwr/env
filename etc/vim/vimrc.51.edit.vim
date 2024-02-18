"------------------------------------------------------
" edit
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
func! RngRemoveSpaces() range
  exec printf('%d,%ds/ //g', a:firstline, a:lastline)
endfunc

func! FormatLines() range
  exec printf('%d,%ds/ //g', a:firstline, a:lastline)
  Tabularize /=dict
  Tabularize /|dict
  Tabularize /,
endfunc

"------------------------------------------------------
func! PgrRemoveSpaces()
  '{,'}call RngRemoveSpaces()
endfunc

func! PgrFormat()
  '{,'}call FormatLines()
endfunc

func! PgrIndentLeft()
  normal <ap
endfunc

func! PgrIndentRight()
  normal >ap
endfunc

