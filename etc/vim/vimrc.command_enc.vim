"------------------------------------------------------
" encoding
"------------------------------------------------------
func s:SetJapanese()
  " encoding
  set fileencodings=japan
  set termencoding=japan
  " input method
  "set imoptions=canna
endf
command JP call s:SetJapanese()

" utf encoding
command EUTF8 e ++enc=utf-8
command WUTF8 w ++enc=utf-8 ++ff=unix
command WUTF8DOS w ++enc=utf-8 ++ff=dos
command EUTF16 e ++enc=utf-16
command WUTF16 e ++enc=utf-16 ++ff=dos

" japanese encoding
command EJIS e ++enc=iso-2022-jp
command WJIS w ++enc=iso-2022-jp ++ff=unix
command EEUCJP e ++enc=euc-jp
command WEUCJP w ++enc=euc-jp ++ff=unix
command ESJIS e ++enc=sjis
command WSJIS w ++enc=sjis ++ff=unix
command ECP932 e ++enc=cp932
command WCP932 w ++enc=cp932 ++ff=dos

" simplified chinese encoding
command EEUCCN e ++enc=euc-cn
command WEUCCN w ++enc=euc-cn ++ff=unix
command ECP936 e ++enc=cp936
command WCP936 w ++enc=cp936 ++ff=dos

