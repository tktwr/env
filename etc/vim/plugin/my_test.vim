"======================================================
" MyTest
"======================================================
"if exists("loaded_my_test")
"  finish
"endif

"let loaded_my_test = 1

func MyTest()
endfunc

func MyTestWinEnter()
  echo "WinEnter: ".expand("%")
endfunc

func MyTestBufRead()
  echo "BufRead: ".expand("%")
endfunc

func MyTestBufEnter()
  echo "BufEnter: ".expand("%")
endfunc

func MyTestBufWinEnter()
  echo "BufWinEnter: ".expand("%")
endfunc

augroup mytest
  autocmd!
  "autocmd WinEnter *       call MyTestWinEnter()
  "autocmd BufRead *        call MyTestBufRead()
  "autocmd BufEnter *       call MyTestBufEnter()
  "autocmd BufWinEnter *    call MyTestBufWinEnter()
augroup END

