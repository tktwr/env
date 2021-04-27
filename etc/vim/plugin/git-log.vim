"======================================================
" GitLog
"======================================================
if exists("loaded_gitlog")
  finish
endif

let loaded_gitlog = 1
let s:gitlog_winname = '\[gitlog\]'

func GitLogMakeWindow()
  exec "edit" s:gitlog_winname
  setlocal filetype=gitlog
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal buflisted
  setlocal noswapfile
  "setlocal readonly
  setlocal nowrap
endfunc

func GitLogUpdate()
  "setlocal modifiable
  %d _
  exec "0r!git-log.sh --log 6 --log-submodule 4"
  normal 1G
  "setlocal nomodifiable
endfunc

func GitLogSyntax()
  syn match myDate           "\d\+/\d\+/\d\+"
  syn match myTime           "\d\+:\d\+"
  syn match myBranch         "(.*)"
  syn match myModify         "^ M"
  syn match myModify         "^ m"
  syn match myUntrack        "^??"
  hi link myDate             MyGreen
  hi link myTime             MyGreen
  hi link myBranch           MyYellow
  hi link myModify           MyRed
  hi link myUntrack          MyRed
endfunc

func GitLogMap()
  nnoremap <buffer> <C-R>   :call GitLogUpdate()<CR>
endfunc

"------------------------------------------------------
" public func
"------------------------------------------------------
func GitLog()
  call GitLogMakeWindow()
  call GitLogUpdate()
endfunc

func GitLogFileType()
  call GitLogSyntax()
  call GitLogMap()
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command GitLog call GitLog()

autocmd FileType gitlog    call GitLogFileType()

