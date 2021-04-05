"======================================================
" statusline
"======================================================
hi! link User1   MyAquaRevBold
hi! link User2   MyAquaRevBold
hi! link User3   MyYellowRevBold

func MyStatuslineWinInfo()
  let l:winnr = winnr()
  return '['.l:winnr.'] '
endfunc

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
  let l:statusline = "%{MyStatuslineWinInfo()}"
  let l:statusline.= MyStatuslineFname()
  let l:statusline.="\ %y%h%w%q%m%r%{MyStatuslineEnc()}"
  "let l:statusline.="\ %{coc#status()}"
  let l:statusline.="\ %=%l/%L,%c%V%4p%%"
  let l:statusline.="\ %2*%{FugitiveStatusline()}%0*"
  return l:statusline
endfunc

func MyStatuslineTermCWD()
  if haslocaldir() == 1
    let l:type = "local"
    let l:cwd = getcwd()
  elseif haslocaldir() == 2
    let l:type = "tab"
    let l:cwd = getcwd(-1, 0)
  else
    let l:type = "global"
    let l:cwd = getcwd(-1)
  endif
  let l:cwd = substitute(l:cwd, expand("$HOME"), '~', "")
  let l:cwd = substitute(l:cwd, expand("$MY_HOME"), '^', "")
  return "[".l:type.":".l:cwd."]"
endfunc

func MyStatuslineTerm()
  let l:statusline = "%{MyStatuslineWinInfo()}"
  let l:statusline.= "[terminal]"
  let l:statusline.="\ %{MyStatuslineTermCWD()}"
  return l:statusline
endfunc

set laststatus=2
set statusline=%!MyStatusline()

func MySetTerm()
  setl statusline=%!MyStatuslineTerm()
endfunc

autocmd TerminalOpen * call MySetTerm()

