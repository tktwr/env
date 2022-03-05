"======================================================
" window
"======================================================
"------------------------------------------------------
" wininfo
"------------------------------------------------------
func MyWinInfo()
  echo "columns               : &columns      : ".&columns
  echo "lines                 : &lines        : ".&lines
  echo "current win's width   : winwidth(0)   : ".winwidth(0)
  echo "current win's height  : winheight(0)  : ".winheight(0)
  echo "current win's winnr   : winnr()       : ".winnr()
  echo "last win's winnr      : winnr('$')    : ".winnr('$')
  echo "current win's bufnr   : winbufnr(0)   : ".winbufnr(0)
  echo "current buf's bufnr   : bufnr('%')    : ".bufnr('%')
  echo "current buf's bufname : bufname('%')  : ".bufname('%')
  echo "current buf's winnr   : bufwinnr('%') : ".bufwinnr('%')
  echo "current buf's winid   : bufwinid('%') : ".bufwinid('%')
endfunc

