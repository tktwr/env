"--------------------------------------------------------------------------
" Vim global plugin
" Description: memo
" Last Change: 2018 Apr 22
" Maintainer:  Takehiro Tawara
"--------------------------------------------------------------------------
if exists("loaded_memo")
  finish
endif

let loaded_memo = 1
let s:memo_winname = '\[memo\]'

func! s:OpenTag(name)
  "exec "below stjump" "memo_".a:name
  exec "tag" "memo_".a:name
endfunc

func! s:DefineCommands()
  nnoremap <buffer> <silent> <CR> :call <SID>OpenTag(expand("<cWORD>"))<CR>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
endfunc

func! s:CmdMemo()
  setlocal modifiable
  silent %d _
  silent exec "r!memo -p"
  normal 1G
  setlocal nomodifiable
endfunc

"--------------------------------------------------------------------------
" Memo()
"--------------------------------------------------------------------------
func! Memo()
  " make a [memo] window
  let s:memo_winnr = bufwinnr(s:memo_winname)
  if s:memo_winnr == -1
    silent exec "edit" s:memo_winname
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal tabstop=8
    let s:memo_winnr = bufwinnr(s:memo_winname)
    call s:DefineCommands()
  endif

  call s:CmdMemo()
endfunc

"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------
command Memo call Memo()

