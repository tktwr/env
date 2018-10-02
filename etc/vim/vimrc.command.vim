"------------------------------------------------------
" command
"------------------------------------------------------

" update the line started with "Last modification: "
func s:UpdateLastModification()
  normal m'
  g/Last modification: /normal f:lD:r !env LC_TIME=C datekJ''
endf
command UpdateLastModification call s:UpdateLastModification()
au BufWritePre,FileWritePre *.html  UpdateLastModification

func s:AddTime()
  silent exec "r!env LC_TIME=C date '+\\%T'"
endfunc
command AddTime call s:AddTime()

func s:AddDate(date)
  silent exec "r!env LC_TIME=C date --date='".a:date."' '+\\%Y/\\%m/\\%d (\\%a)'"
endfunc
command -nargs=? AddDate call s:AddDate("<args>")

func s:InsertDia(date)
  normal O<!---------------------------------------------------->
  call s:AddDate(a:date)
  normal I## 
  normal 0
endfunc
command -nargs=? InsertDia call s:InsertDia("<args>")

command CDHERE cd %:h
command LCDHERE lcd %:h
command -nargs=1 SetTab set tabstop=<args> shiftwidth=<args>
command -nargs=1 -complete=file VSPR rightbelow vsplit <args>
"command -nargs=+ Grep execute 'silent grep! <args>' | copen

