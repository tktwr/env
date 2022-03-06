func MyVimgrep(word, files)
  let word = MyPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word a:files
endfunc

