func MyQuickhl(word)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  exec "QuickhlManualAdd!" word
endfunc

