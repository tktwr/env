"======================================================
" statusline
"======================================================
hi! link User1   MyAquaRevBold
hi! link User2   MyAquaRevBold
hi! link User3   MyYellowRevBold

func MyStatuslineFname()
  let l:cwd = getcwd()
  let l:dir = expand("%:p:h")
  let l:filepath = "%<%f"
  let l:color = "%1*"
  if (l:cwd != l:dir)
    let l:color = "%3*"
  endif
  return l:color.l:filepath."%0*"
endfunc

func MyStatuslineEnc()
  let l:fenc = &fenc != '' ? &fenc : &enc
  let l:ff = &ff
  return '['.l:fenc.','.l:ff.']'
endfunc

func MyStatusline()
  let l:statusline = MyStatuslineFname()
  let l:statusline.="\ %h%m%r%w%{MyStatuslineEnc()}"
  "let l:statusline.="\ %{coc#status()}"
  let l:statusline.="\ %=%l/%L,%c%V%4p%%"
  let l:statusline.="\ %2*%{FugitiveStatusline()}%0*"
  return l:statusline
endfunc

func MyStatuslineTerm()
  let l:statusline = "[terminal]"
  let l:cwd = getcwd()
  let l:cwd = substitute(l:cwd, expand("$HOME"), '~', "")
  let l:statusline.="\ [cwd:".l:cwd."]"
  return l:statusline
endfunc

func MySetTerm()
  setl statusline=%!MyStatuslineTerm()
endfunc

set laststatus=2
set statusline=%!MyStatusline()

autocmd TerminalOpen * call MySetTerm()

