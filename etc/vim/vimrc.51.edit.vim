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
" Range functions
"------------------------------------------------------
func! R_RemoveSpaces() range
  exec printf('%d,%ds/ //g', a:firstline, a:lastline)
endfunc

func! R_FormatLines() range
  exec printf('%d,%ds/ //g', a:firstline, a:lastline)
  Tabularize /=dict
  Tabularize /|dict
  Tabularize /,
  Tabularize /;
  Tabularize /,
  Tabularize /;
  Tabularize /,
  Tabularize /;
  Tabularize /,
  Tabularize /;
  Tabularize /,
  Tabularize /;
endfunc

"------------------------------------------------------
" Paragraph functions
"------------------------------------------------------
func! P_RemoveSpaces()
  '{,'}call R_RemoveSpaces()
endfunc

func! P_Format()
  '{,'}call R_FormatLines()
endfunc

func! P_IndentLeft()
  normal <ap
endfunc

func! P_IndentRight()
  normal >ap
endfunc

"------------------------------------------------------
" Buffer functions
"------------------------------------------------------
func B_ClangFormat()
  !clang-format -i %
endfunc

