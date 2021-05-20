"======================================================
" MyTest
"======================================================
"if exists("loaded_my_test")
"  finish
"endif

"let loaded_my_test = 1

"------------------------------------------------------
" private func
"------------------------------------------------------
func MyTestEcho(msg)
  echo a:msg.": ".expand("%")
endfunc

func MyTestCloseHandler(channel)
  while ch_status(a:channel, {'part': 'out'}) == 'buffered'
    echomsg ch_read(a:channel)
  endwhile
endfunc

func MyTestHandler(channel, msg)
  echo "from the handler: " . a:msg
endfunc

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func MyTestSetAutocmd()
  augroup mytest
    autocmd!
    autocmd WinEnter *       call MyTestEcho("WinEnter")
    autocmd WinLeave *       call MyTestEcho("WinLeave")
    autocmd BufRead *        call MyTestEcho("BufRead")
    autocmd BufEnter *       call MyTestEcho("BufEnter")
    autocmd BufLeave *       call MyTestEcho("BufLeave")
    autocmd BufWinEnter *    call MyTestEcho("BufWinEnter")
    autocmd BufWinLeave *    call MyTestEcho("BufWinLeave")
  augroup END
endfunc

"------------------------------------------------------
" public func
"------------------------------------------------------
func MyTestInit()
  set cmdheight=10
  call MyTestSetAutocmd()
endfunc

func MyTest(args)
  echo a:args
  "let job = job_start("git graph -10", {"close_cb": "MyTestCloseHandler"})
  let job = job_start("git graph -10", {"callback": "MyTestHandler"})
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=0 MyTestInit call MyTestInit()
command -nargs=1 MyTest     call MyTest(<f-args>)

