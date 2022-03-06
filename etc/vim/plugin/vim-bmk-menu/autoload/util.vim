"------------------------------------------------------
" util
"------------------------------------------------------
func TtGetDirName(filepath)
  return substitute(a:filepath, "/[^/]*$", "", "")
endfunc

"------------------------------------------------------
" buffer
"------------------------------------------------------
func TtClear()
  silent %d _
endfunc

func TtPut0(text)
  silent 0put =a:text
endfunc

func TtPut(text)
  silent put =a:text
endfunc

func TtRemoveBeginSpaces(line)
  return substitute(a:line, '^\s*', '', '')
endfunc

func TtRemoveEndSpaces(line)
  return substitute(a:line, '\s*$', '', '')
endfunc

func TtRemoveBeginEndSpaces(line)
  return TtRemoveBeginSpaces(TtRemoveEndSpaces(a:line))
endfunc

func TtSystem(cmd)
  let out = system(a:cmd)
  return substitute(out, "\<CR>", '', 'g')
endfunc

