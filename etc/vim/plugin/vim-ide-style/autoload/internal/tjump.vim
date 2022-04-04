func MyTjump(tag_name, winnr=0)
  call TtGotoWinnr(a:winnr)
  exec "tjump ".a:tag_name
endfunc

func MyTjumpPrompt()
  let line = MyPrompt("tag winnr? ", '??')
  if line == ""
    return
  endif

  exec "MyTjump" line
endfunc

