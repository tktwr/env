"------------------------------------------------------
" func & command
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
command -nargs=+ Grep execute 'silent vimgrep <args> **/*.h **/*.cpp **/*.cxx **/*.vim **/*.md.html **/*.txt'

"------------------------------------------------------
" dev
"------------------------------------------------------

func s:EditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cpp"
  endif
  exec "edit" fname
endf
command EditAltSrc call s:EditAltSrc()

"------------------------------------------------------
" diff
"------------------------------------------------------

set diffopt=filler,vertical,iwhite
func s:SetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc
autocmd VimEnter,FilterWritePre * call s:SetDiffMode()

"------------------------------------------------------
" encoding
"------------------------------------------------------
func s:SetJapanese()
  " encoding
  set fileencodings=japan
  set termencoding=japan
endf
command JP call s:SetJapanese()

" utf encoding
command EUTF8    e ++enc=utf-8
command WUTF8    w ++enc=utf-8 ++ff=unix
command WUTF8DOS w ++enc=utf-8 ++ff=dos
command EUTF16   e ++enc=utf-16
command WUTF16   e ++enc=utf-16 ++ff=dos

" japanese encoding
command EJIS   e ++enc=iso-2022-jp
command WJIS   w ++enc=iso-2022-jp ++ff=unix
command EEUCJP e ++enc=euc-jp
command WEUCJP w ++enc=euc-jp ++ff=unix
command ESJIS  e ++enc=sjis
command WSJIS  w ++enc=sjis ++ff=unix
command ECP932 e ++enc=cp932
command WCP932 w ++enc=cp932 ++ff=dos

" simplified chinese encoding
command EEUCCN e ++enc=euc-cn
command WEUCCN w ++enc=euc-cn ++ff=unix
command ECP936 e ++enc=cp936
command WCP936 w ++enc=cp936 ++ff=dos

