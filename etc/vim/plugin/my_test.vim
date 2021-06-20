"======================================================
" MyTest
"======================================================
"let g:loaded_my_test = 1
if exists("g:loaded_my_test")
  finish
endif
let g:loaded_my_test = 1

"------------------------------------------------------
" test args
"------------------------------------------------------
func MyTestFargs(arg)
  echom "MyTestFargs: [".a:arg."]"
endfunc

func MyTestQargs(arg)
  echom "MyTestQargs: [".a:arg."]"
endfunc

"------------------------------------------------------
" test autocmd
"------------------------------------------------------
func EventMsg(msg)
  echo a:msg.": ".expand("%")
endfunc

func MyTestAutocmd()
  augroup mytest
    autocmd!
    autocmd FileType txt     call EventMsg("FileType txt")
    autocmd FileType bmk     call EventMsg("FileType bmk")
    autocmd WinEnter *       call EventMsg("WinEnter")
    autocmd WinLeave *       call EventMsg("WinLeave")
    autocmd BufRead *        call EventMsg("BufRead")
    autocmd BufEnter *       call EventMsg("BufEnter")
    autocmd BufLeave *       call EventMsg("BufLeave")
    autocmd BufWinEnter *    call EventMsg("BufWinEnter")
    autocmd BufWinLeave *    call EventMsg("BufWinLeave")
  augroup END
endfunc

"------------------------------------------------------
" test popup_create
"------------------------------------------------------
func MyTestPopupCreate()
  let s:popup_winid = popup_create("hello world", {})
endfunc

func MyTestPopupClose()
  call popup_close(s:popup_winid)
endfunc

"------------------------------------------------------
" test popup_dialog
"------------------------------------------------------
func MyTestPopupDialogHandler(id, result)
  echom a:result
  if a:result
    echom "yes"
  else
    echom "no"
  endif
endfunc

func MyTestPopupDialog()
  call popup_dialog('Continue? y/n', #{
    \ filter: 'popup_filter_yesno',
    \ callback: 'MyTestPopupDialogHandler',
    \ })
endfunc

"------------------------------------------------------
" test popup_menu
"------------------------------------------------------
func MyTestPopupMenuFilter(id, key)
  " Handle shortcuts
  if a:key == 'S'
     call popup_close(a:id, 1)
     return 1
  endif
  if a:key == 'C'
     call popup_close(a:id, 2)
     return 1
  endif
  if a:key == 'D'
     call popup_close(a:id, 3)
     return 1
  endif

  " No shortcut, pass to generic filter
  return popup_filter_menu(a:id, a:key)
endfunc

func MyTestPopupMenuHandler(id, result)
  echo a:result
  if &buftype == 'terminal'
    let l:bufnr = winbufnr(0)
    "let l:cmd = "git status\<CR>"
    let l:cmd = "git status"
    call term_sendkeys(l:bufnr, l:cmd)
  endif
endfunc

func MyTestPopupMenu()
  let cmd_list = ['Save', 'Cancel', 'Discard']
  call popup_menu(cmd_list, #{
    \ filter: 'MyTestPopupMenuFilter',
    \ callback: 'MyTestPopupMenuHandler',
    \ border: [0,0,0,0],
    \ padding: [0,0,0,0],
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ moved: 'WORD',
    \ })
endfunc

"------------------------------------------------------
" test balloon
"------------------------------------------------------
func BalloonExpr()
  if s:winid && popup_getpos(s:winid) != {}
    " previous popup window still shows
    if v:beval_text == s:last_text
      " Still the same text, keep the existing popup
      return ''
    endif
    call popup_close(s:winid)
  endif
  let s:winid = popup_beval(v:beval_text, #{mousemoved: 'word'})
  let s:last_text = v:beval_text
  return ''
endfunc

func MyTestSetBalloon()
  set ballooneval balloonevalterm
  set balloonexpr=BalloonExpr()
  let s:winid = 0
  let s:last_text = ''
endfunc

"------------------------------------------------------
" test job
"------------------------------------------------------
func MyTestJobCloseHandler(channel)
  let text = ""
  let i = 1
  while ch_status(a:channel, {'part': 'out'}) == 'buffered'
    let text = ch_read(a:channel)
    call setline(i, text)
    let i = i + 1
  endwhile
endfunc

func MyTestJobStartClose()
  let cmd = "ls -l"
  let s:job = job_start(cmd, {"close_cb": "MyTestJobCloseHandler"})
endfunc

"------------------------------------------------------
" test job
"------------------------------------------------------
func MyTestHello()
  let i = 1
  while i <= 20
    let text = "hello " . i
    call setline(i, text)
    redraw
    sleep 1
    let i = i + 1
  endwhile
endfunc

func MyTestJobHandler(channel, msg)
  call setline(1, a:msg)
endfunc

func MyTestJobStart()
  let s:job = job_start("hello", {"callback": "MyTestJobHandler"})
  "let s:job = job_start("MyTestHello", {"callback": "MyTestJobHandler"})
endfunc

func MyTestJobStop()
  call job_stop(s:job)
endfunc

func MyTestJobStatus()
  echom job_status(s:job)
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=+ MyTestFargs     call MyTestFargs(<f-args>)
command -nargs=+ MyTestQargs     call MyTestQargs(<q-args>)

command MyTestAutocmd       call MyTestAutocmd()

command MyTestPopupCreate   call MyTestPopupCreate()
command MyTestPopupClose    call MyTestPopupClose()
command MyTestPopupDialog   call MyTestPopupDialog()
command MyTestPopupMenu     call MyTestPopupMenu()
command MyTestSetBalloon    call MyTestSetBalloon()

command MyTestJobStartClose call MyTestJobStartClose()
command MyTestJobStart      call MyTestJobStart()
command MyTestJobStop       call MyTestJobStop()
command MyTestJobStatus     call MyTestJobStatus()

