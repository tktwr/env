func MyRef(cmd, word)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "vertical resize" g:my_help_winwidth
  if &filetype =~ "ref-*"
    exec "above Ref" a:cmd word
  else
    exec "above Ref" a:cmd word
    call MyClosePrevWin()
  endif
endfunc

