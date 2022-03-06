func MyGgrep(word)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "Ggrep -I" word "-- ':!tags*'"
endfunc

func MyGstatusToggle()
  if (&filetype == "fugitive")
    normal q
  else
    above Git
    exec "resize" g:my_gstatus_winheight
  endif
endfunc

func MyFugitiveMap()
  nmap <buffer> D       dd
endfunc

