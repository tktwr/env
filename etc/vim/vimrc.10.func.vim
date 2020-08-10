"======================================================
" func & command
"======================================================

command RunExplorer silent !explorer.exe %:h
command RunGvim     silent !gvim "%"
command RunVscode   silent !vscode.sh "%"
command RunChrome   silent !chrome.sh "%"
command RunFirefox  silent !firefox "%"

command Trans bot term ++rows=10 ++close trans -I -b

command MyCdHere cd %:h
command MyLcdHere lcd %:h
command -nargs=1 MySetTab set tabstop=<args> shiftwidth=<args>
command -nargs=1 -complete=file MyVspRight rightbelow vsplit <args>
command -nargs=+ MyGrep execute 'silent vimgrep <args> **/*.h **/*.cpp **/*.cxx **/*.vim **/*.html **/*.txt **/*.sh'

func s:MyIDE()
  NERDTree
  wincmd l
  Tagbar
endf
command MyIDE call s:MyIDE()

func s:MyCheckEnv()
  echo "version: ".v:version
  echo "unix: ".has("unix")
  echo "win32unix: ".has("win32unix")
  echo "win32: ".has("win32")
  echo "win64: ".has("win64")
  echo "python: ".has("python")
  if has("python")
    py print(sys.version)
  endif
  echo "python3: ".has("python3")
  if has("python3")
    py3 print(sys.version)
  endif
  echo "gui_running: ".has("gui_running")
  echo "term: ".&term
  echo "shell: ".&shell
  echo "path: ".&path
  echo "runtimepath: ".&runtimepath
  pwd
endf
command MyCheckEnv call s:MyCheckEnv()

"------------------------------------------------------
" func: edit
"------------------------------------------------------

" update the line started with "Last modification: "
func s:MyUpdateLastModification()
  normal m'
  g/Last modification: /normal f:lD:r !env LC_TIME=C datekJ''
endf

func s:MyAddTime()
  silent exec "r!env LC_TIME=C date '+\\%T'"
endfunc

func s:MyAddDate(date)
  silent exec "r!env LC_TIME=C date --date='".a:date."' '+\\%Y/\\%m/\\%d (\\%a)'"
endfunc

func s:MyInsertDia(date)
  normal O<!---------------------------------------------------->
  call s:MyAddDate(a:date)
  normal I## 
  normal 0
endfunc

command MyUpdateLastModification call s:MyUpdateLastModification()
au BufWritePre,FileWritePre *.html  MyUpdateLastModification
command MyAddTime call s:MyAddTime()
command -nargs=? MyAddDate call s:MyAddDate("<args>")
command -nargs=? MyInsertDia call s:MyInsertDia("<args>")

"------------------------------------------------------
" func: dev
"------------------------------------------------------

func s:MyEditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cpp"
  endif
  exec "edit" fname
endf

func s:MyStartProf()
  profile start prof.txt
  profile func *
  profile file *
endf

func s:MyEndProf()
  profile pause
  noautocmd qall!
endf

command MyEditAltSrc call s:MyEditAltSrc()
command MyStartProf call s:MyStartProf()
command MyEndProf call s:MyEndProf()

"------------------------------------------------------
" func: diff
"------------------------------------------------------

set diffopt=filler,vertical,iwhite
func s:MySetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc

autocmd VimEnter,FilterWritePre * call s:MySetDiffMode()

"------------------------------------------------------
" func: encoding
"------------------------------------------------------
func s:MySetJapanese()
  " encoding
  set fileencodings=japan
  set termencoding=japan
endf

command JP call s:MySetJapanese()

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

