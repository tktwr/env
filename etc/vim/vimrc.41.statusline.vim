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

func MyStatusline()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "\ ".TtStatuslineFname()
  let stat.= "\ %m%y%h%w%q%r%{TtStatuslineEnc()}"
  let stat.= "\ %=%l/%L,%c%V%4p%%"
  if $MY_PROMPT_TYPE >= 3
    let stat.= "\ %6*%{FugitiveStatusline()}"
  endif
  let stat.= "\ %0*"
  return stat
endfunc

set laststatus=2
set statusline=%!MyStatusline()

"------------------------------------------------------
" statusline for terminal
"------------------------------------------------------
func MyStatuslineTerm()
  let stat = "%{TtStatuslineWinNr()}"
  let stat.= "\ [terminal]"
  let stat.= "\ %<%f"
  let stat.= "\ %=%{MyCWD()}"
  return stat
endfunc

func MySetTerm()
  setl statusline=%!MyStatuslineTerm()
endfunc

augroup ag_my_term
  autocmd!
  if !has('nvim')
    autocmd TerminalOpen * call MySetTerm()
  else
    autocmd TermOpen * call MySetTerm()
  endif
augroup END

