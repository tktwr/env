"======================================================
" Memo
"======================================================
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

func! s:OpenTag(tagname)
  "exec "below stjump" "memo_".a:tagname
  exec "tag" "memo_".a:tagname
  exec "normal z\<CR>"
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
command -nargs=? Memo call s:Memo(<q-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func! s:DefineCommands()
  nnoremap <buffer> <silent> <CR> :call <SID>OpenTag(expand("<cWORD>"))<CR>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
endfunc

func! s:MemoSyntax()
  syn keyword  memoCPP             cpp
  syn keyword  memoCPP_LIB         cpp_lib
  syn keyword  memoPY              py
  syn keyword  memoSH              sh
  syn keyword  memoVIM             vim
  syn keyword  memoGIT             git
  syn keyword  memoINIT            init
  syn keyword  memoMY              my
  syn keyword  memoOS              os
  syn keyword  memoPROG            prog
  syn keyword  memoDEV             dev
  syn match    memoTAG             "\[[^]]*\]"
  hi link memoCPP             MyRed
  hi link memoCPP_LIB         MyRed
  hi link memoPY              MyYellow
  hi link memoSH              MyOrange
  hi link memoVIM             MyGreen
  hi link memoGIT             MyAqua
  hi link memoINIT            MyPurple
  hi link memoMY              MyBlue
  hi link memoOS              MyYellow
  hi link memoPROG            MyRed
  hi link memoDEV             MyGreen
  hi link memoTAG             MyPurple
endfunc

func! s:MemoFileType()
  call s:DefineCommands()
  call s:MemoSyntax()
endfunc

augroup ag_memo
  autocmd!
  autocmd FileType memo    call s:MemoFileType()
augroup END

