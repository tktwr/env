Plug 'tktwr/vim-winbuf-menu'
Plug 'tktwr/vim-bmk-menu'
Plug 'tktwr/vim-ide-style'

func MyVimgrepAll(word)
  let word = vis#util#VisPrompt("Word? ", a:word)
  if word == ""
    return
  endif

  lcd %:h
  silent exec "vimgrep" word '$MY_BMK/*.txt' '$MY_BIN/*.sh' '$MY_BASH/*.sh' '$MY_VIM/*.vim' '$MY_VIM/plugin/*.vim' '$MY_VIM/plugged/vim-ide-style/**/*.vim' '$MY_VIM/plugged/vim-bmk-menu/**/*.vim' '$MY_VIM/plugged/vim-winbuf-menu/**/*.vim'
endfunc

