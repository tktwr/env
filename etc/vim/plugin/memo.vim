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

func! s:ListTags()
  setlocal modifiable
  silent %d _
  silent exec "r!memo -p"
  normal 1G
  setlocal nomodifiable
endfunc

func! s:OpenTag(tagname)
  "exec "below stjump" "memo_".a:tagname
  exec "tag" "memo_".a:tagname
endfunc

func! s:DefineCommands()
  nnoremap <buffer> <silent> <CR> :call <SID>OpenTag(expand("<cWORD>"))<CR>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
endfunc

" make a [memo] window
func! s:MakeMemoWindow()
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
endfunc

"--------------------------------------------------------------------------
" Memo()
"--------------------------------------------------------------------------

func! Memo(tagname)
  if (empty(a:tagname))
    call s:MakeMemoWindow()
    call s:ListTags()
  else
    call s:OpenTag(a:tagname)
  endif
endfunc

"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------
command -nargs=? Memo call Memo(<q-args>)

