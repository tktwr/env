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
  let stat.= TtStatuslineFname()
  let stat.= "%{TtStatuslineFileType()}"
  let stat.= TtStatuslineIndicator()
  let stat.= "%{TtStatuslineFileEnc()}"
  let stat.= TtStatuslineSeparator()
  let stat.= TtStatuslineLineInfo()

  if $MY_PROMPT_TYPE >= 3
    let stat.= "%6*%{FugitiveStatusline()}%0*"
  endif
  return stat
endfunc

set laststatus=2
set statusline=%!MyStatusline()

