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
  silent exec "0r!memo -c=".winwidth(0)." -p"
  normal 1G
  setlocal nomodifiable
endfunc

func! s:OpenTag(tagname)
  "exec "below stjump" "memo_".a:tagname
  exec "tag" "memo_".a:tagname
  exec "normal z\<CR>"
endfunc

func! s:DefineCommands()
  nnoremap <buffer> <silent> <CR> :call <SID>OpenTag(expand("<cWORD>"))<CR>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
endfunc

" make a [memo] window
func! s:MakeMemoWindow(vert)
  let s:memo_winnr = bufwinnr(s:memo_winname)
  if s:memo_winnr == -1
    if (a:vert)
      silent exec "rightbelow 60vnew" s:memo_winname
    else
      silent exec "15new" s:memo_winname
    endif
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal buflisted
    setlocal noswapfile
    setlocal readonly
    setlocal tabstop=8
    let s:memo_winnr = bufwinnr(s:memo_winname)
    call s:DefineCommands()
  else
    exec s:memo_winnr . "wincmd w"
  endif
endfunc

"--------------------------------------------------------------------------
" s:Memo()
"--------------------------------------------------------------------------

func! s:Memo(tagname)
  call s:MakeMemoWindow(0)
  call s:ListTags()
  if (!empty(a:tagname))
    call s:OpenTag(a:tagname)
  endif
endfunc

func! s:Ref(tagname)
  call s:MakeMemoWindow(1)
  call s:ListTags()
  if (!empty(a:tagname))
    call s:OpenTag(a:tagname)
  endif
endfunc

"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------
command -nargs=? Memo call s:Memo(<q-args>)
"command -nargs=? Ref call s:Ref(<q-args>)

