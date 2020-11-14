"======================================================
" command
"======================================================
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

"------------------------------------------------------
command RunExplorer silent !explorer.exe %:h
command RunGvim     silent !gvim "%"
command RunVscode   silent !vscode.sh "%"
command RunChrome   silent !chrome.sh "%"
command RunFirefox  silent !firefox "%"

command ClangFormat !clang-format -i %
command TabBar Tabularize /|
command TabDot Tabularize /\.\.\.

command Trans bot term ++rows=10 ++close trans -I -b

command -nargs=+ VimGrep call s:MyVimGrep("<args>")
command VimGrepHere VimGrep <cword>
command GgrepHere Ggrep -I <cword> -- ':!*.dat'

command MyCdHere cd %:h
command MyLcdHere lcd %:h
command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>
command -nargs=1 MySetTab call s:MySetTab("<args>")
command MyLineNumberToggle call s:MyLineNumberToggle()
command MyIDE call s:MyIDE()
command MyCheckEnv call s:MyCheckEnv()

command MyUpdateLastModification call s:MyUpdateLastModification()
command MyAddTime call s:MyAddTime()
command -nargs=? MyAddDate call s:MyAddDate("<args>")
command -nargs=? MyInsertDia call s:MyInsertDia("<args>")

command MyEditAltSrc call s:MyEditAltSrc()
command MyStartProf call s:MyStartProf()
command MyEndProf call s:MyEndProf()

"------------------------------------------------------
" autocmd
"------------------------------------------------------
au BufWritePre,FileWritePre *.html  MyUpdateLastModification
au VimEnter,FilterWritePre * call s:MySetDiffMode()

