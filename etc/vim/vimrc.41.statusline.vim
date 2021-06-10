"======================================================
" statusline
"======================================================
hi! link User1   MyRedRevBold
hi! link User2   MyGreenRevBold
hi! link User3   MyYellowRevBold
hi! link User4   MyBlueRevBold
hi! link User5   MyPurpleRevBold
hi! link User6   MyAquaRevBold
hi! link User7   MyOrangeRevBold

func MyStatuslineWinNr()
  let winnr = winnr()
  return '['.winnr.']'
endfunc

func MyStatuslineFname()
  let cwd = getcwd()
  let dir = expand("%:p:h")
  let color = "%6*"
  if (cwd != dir)
    let color = "%3*"
  endif
  return color."%<%f"."%0*"
endfunc

func MyStatuslineEnc()
  let fenc = &fenc != '' ? &fenc : &enc
  let ff = &ff
  return '['.fenc.','.ff.']'
endfunc

func MyStatusline()
  let stat = "%{MyStatuslineWinNr()}"
  let stat.= "\ ".MyStatuslineFname()
  let stat.= "\ %y%h%w%q%m%r%{MyStatuslineEnc()}"
  let stat.= "\ %=%l/%L,%c%V%4p%%"
  let stat.= "\ %6*%{FugitiveStatusline()}%0*"
  return stat
endfunc

set laststatus=2
set statusline=%!MyStatusline()

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func MyStatuslineTerm()
  let stat = "%{MyStatuslineWinNr()}"
  let stat.= "\ [terminal]"
  let stat.= "\ %<%f"
  let stat.= "\ %=%{MyCWD()}"
  return stat
endfunc

func MySetTerm()
  setl statusline=%!MyStatuslineTerm()
endfunc

autocmd TerminalOpen * call MySetTerm()

