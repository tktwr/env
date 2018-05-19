"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------

" update the line started with "Last modification: "
func s:UpdateLastModification()
  normal m'
  g/Last modification: /normal f:lD:r !env LC_TIME=C datekJ''
endf
command UpdateLastModification call s:UpdateLastModification()
au BufWritePre,FileWritePre *.html  UpdateLastModification

func s:InsertTime()
  silent exec "r!env LC_TIME=C date '+\\%T'"
endfunc
command InsertTime call s:InsertTime()

func s:InsertDate(date)
  silent exec "r!env LC_TIME=C date --date=\"".a:date."\" '+\\%Y/\\%m/\\%d (\\%a)'"
endfunc
command -nargs=1 InsertDate call s:InsertDate(<args>)

func s:AddToday()
  call s:InsertDate("today")
  normal o#------------------------------------------------------
  normal -
endfunc
command AddToday call s:AddToday()

command CDHERE cd %:h
command LCDHERE lcd %:h
command -nargs=1 SetTab set tabstop=<args> shiftwidth=<args>
command -nargs=1 -complete=file VSPR rightbelow vsplit <args>
"command -nargs=+ Grep execute 'silent grep! <args>' | copen

