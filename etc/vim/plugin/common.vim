"======================================================
" common
"======================================================
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

"------------------------------------------------------
" statusline
"------------------------------------------------------
func TtStatuslineFname()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = ""
  if (cwd != dir)
    let color = "%3*"
  else
    let color = "%6*"
  endif
  "return color."%f"."%0* "
  return color."%t"."%0* "
endfunc

func TtStatuslineFileType()
  let ft = getwinvar(0, '&ft')
  let syn = getwinvar(0, '&syn')

  if ft == syn
    let type = "[".ft."]"
  else
    let type = "[".ft.",".syn."]"
  endif

  return type
endfunc

func TtStatuslineIndicator()
  return "%m%r%w%q"
endfunc

func TtStatuslineFileEnc()
  let stat = ""
  if winwidth(0) >= 60
    let fenc = &fenc != '' ? &fenc : &enc
    let ff = &ff
    let stat = printf("[%s,%s]", fenc, ff)
  endif
  return stat
endfunc

func TtStatuslineLineInfo()
  let stat = ""
  if winwidth(0) >= 60
    let stat = "[%c%V,%l/%L,%p%%]"
  endif
  return stat
endfunc

func TtStatuslineSeparator()
  return "%<%="
endfunc

