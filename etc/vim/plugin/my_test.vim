"======================================================
" MyTest
"======================================================
"if exists("g:loaded_my_test")
"  finish
"endif
"let g:loaded_my_test = 1

"------------------------------------------------------
" private func
"------------------------------------------------------
func MyTestEcho(msg)
  echo a:msg.": ".expand("%")
endfunc

func MyTestCloseHandler(channel)
  let text = ""
  let i = 1
  while ch_status(a:channel, {'part': 'out'}) == 'buffered'
    let text = ch_read(a:channel)
    call setline(i, text)
    let i = i + 1
  endwhile
endfunc

func MyTestHandler(channel, msg)
  call setline(1, a:msg)
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
" popup: dialog
"------------------------------------------------------
func MyDialogHandler(id, result)
  echo a:result
  if a:result
    " ... 'y' or 'Y' was pressed
  endif
endfunc

func MyDialog()
  call popup_dialog('Continue? y/n', #{
    \ filter: 'popup_filter_yesno',
    \ callback: 'MyDialogHandler',
    \ })
endfunc

"------------------------------------------------------
" popup: simple
"------------------------------------------------------
func MyPopupCreate()
  let s:popup_winid = popup_create("hello world", {})
endfunc

func MyPopupClose()
  call popup_close(s:popup_winid)
endfunc

"------------------------------------------------------
" popup: menu
"------------------------------------------------------
func MyMenuFilter(id, key)
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

func MyMenuHandler(id, result)
  echo a:result
  if &buftype == 'terminal'
    let l:bufnr = winbufnr(0)
    "let l:cmd = "git status\<CR>"
    let l:cmd = "git status"
    call term_sendkeys(l:bufnr, l:cmd)
  endif
endfunc

func MyPopupMenu2()
  call popup_atcursor(s:cmd_list, #{
    \ })
endfunc

let s:cmd_list = ['Save', 'Cancel', 'Discard']

func MyPopupMenu()
  call popup_menu(s:cmd_list, #{
    \ filter: 'MyMenuFilter',
    \ callback: 'MyMenuHandler',
    \ border: [0,0,0,0],
    \ padding: [0,0,0,0],
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ moved: 'WORD',
    \ })
endfunc

"------------------------------------------------------
" popup: balloon
"------------------------------------------------------
set ballooneval balloonevalterm
set balloonexpr=BalloonExpr()
let s:winid = 0
let s:last_text = ''

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
"------------------------------------------------------
" public func
"------------------------------------------------------
func MyTestInit()
  set cmdheight=10
  call MyTestSetAutocmd()
endfunc

func MyTestStartClose()
  let cmd = "ls -l"
  let s:job = job_start(cmd, {"close_cb": "MyTestCloseHandler"})
endfunc

func MyTestStart()
  "let s:job = job_start("hello", {"callback": "MyTestHandler"})
  let s:job = job_start("MyTestHello", {"callback": "MyTestHandler"})
endfunc

func MyTestStop()
  call job_stop(s:job)
endfunc

func MyTestStatus()
  echom job_status(s:job)
endfunc

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

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=0 MyTestInit call MyTestInit()
command -nargs=1 MyTest     call MyTest(<f-args>)

