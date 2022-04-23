"======================================================
" Memo
"======================================================
"unlet g:loaded_memo

if exists("g:loaded_memo")
  finish
endif
let g:loaded_memo = 1

let s:memo_winname = '\[memo\]'

"------------------------------------------------------
" private func
"------------------------------------------------------
func! s:ListTags()
  setlocal modifiable
  silent %d _
  silent exec "0r!memo -c=".winwidth(0)." -p"
  normal 1G
  setlocal nomodifiable
endfunc

func! s:OpenTag(tagname, winnr=0)
  let winnr = vis#window#VisFindEditor(a:winnr)
  call vis#window#VisGotoWinnr(winnr)

  "exec "below stjump" "memo_".a:tagname
  exec "tag" "memo_".a:tagname
  exec "normal z\<CR>"
endfunc

func! s:PreviewTag(tagname, winnr=0)
  let prev_winnr = winnr()
  call s:OpenTag(a:tagname, a:winnr)
  exec prev_winnr."wincmd w"
endfunc

" make a [memo] window
func! s:MakeMemoWindow()
  let s:memo_winnr = bufwinnr(s:memo_winname)
  if s:memo_winnr == -1
    silent exec "edit" s:memo_winname
    setlocal filetype=memo
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal buflisted
    setlocal noswapfile
    setlocal readonly
    setlocal tabstop=8
    let s:memo_winnr = bufwinnr(s:memo_winname)
  else
    exec s:memo_winnr . "wincmd w"
  endif
endfunc

"------------------------------------------------------
" s:Memo()
"------------------------------------------------------
func! s:Memo(tagname)
  call s:MakeMemoWindow()
  call s:ListTags()
  if (!empty(a:tagname))
    call s:OpenTag(a:tagname)
  endif
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command! -nargs=? Memo call s:Memo(<q-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func! s:DefineCommands()
  if (vis#sidebar#VisInSideBar())
    nnoremap <buffer> l     :call <SID>PreviewTag(expand("<cWORD>"), -2)<CR>
  else
    nnoremap <buffer> <silent> l W
  endif

  nnoremap <buffer> <silent> h B

  nnoremap <buffer> <silent> <CR> :call <SID>OpenTag(expand("<cWORD>"))<CR>

  nnoremap <buffer> 2     :call <SID>OpenTag(expand("<cWORD>"), 2)<CR>
  nnoremap <buffer> 3     :call <SID>OpenTag(expand("<cWORD>"), 3)<CR>
  nnoremap <buffer> 4     :call <SID>OpenTag(expand("<cWORD>"), 4)<CR>
  nnoremap <buffer> 5     :call <SID>OpenTag(expand("<cWORD>"), 5)<CR>
  nnoremap <buffer> 6     :call <SID>OpenTag(expand("<cWORD>"), 6)<CR>
  nnoremap <buffer> 7     :call <SID>OpenTag(expand("<cWORD>"), 7)<CR>
  nnoremap <buffer> 8     :call <SID>OpenTag(expand("<cWORD>"), 8)<CR>
  nnoremap <buffer> 9     :call <SID>OpenTag(expand("<cWORD>"), 9)<CR>
endfunc

func! s:MemoSyntax()
  syn keyword  memo_cpp             cpp
  syn keyword  memo_cpp_lib         cpp_lib
  syn keyword  memo_py              py
  syn keyword  memo_sh              sh
  syn keyword  memo_vim             vim
  syn keyword  memo_git             git
  syn keyword  memo_init            init
  syn keyword  memo_my              my
  syn keyword  memo_os              os
  syn keyword  memo_prog            prog
  syn keyword  memo_dev             dev

  syn keyword  memo_scratchpad     scratchpad
  syn keyword  memo_info           info
  syn keyword  memo_diary          diary
  syn keyword  memo_todo           todo

  syn match    memo_tag             "\[[^]]*\]"

  hi link memo_cpp            MyRed
  hi link memo_cpp_lib        MyRed
  hi link memo_py             MyYellow
  hi link memo_sh             MyOrange
  hi link memo_vim            MyGreen
  hi link memo_git            MyAqua
  hi link memo_init           MyPurple
  hi link memo_my             MyBlue
  hi link memo_os             MyYellow
  hi link memo_prog           MyRed
  hi link memo_dev            MyGreen

  hi link memo_scratchpad     MyGreen
  hi link memo_info           MyRed
  hi link memo_diary          MyYellow
  hi link memo_todo           MyOrange

  hi link memo_tag            MyPurple
endfunc

func! s:MemoFileType()
  call s:DefineCommands()
  call s:MemoSyntax()
endfunc

augroup ag_memo
  autocmd!
  autocmd FileType memo    call s:MemoFileType()
augroup END

