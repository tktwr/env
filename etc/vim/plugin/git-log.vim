"======================================================
" GitLog
"======================================================
if exists("loaded_gitlog")
  finish
endif

let loaded_gitlog = 1
let s:gitlog_winname = '\[gitlog\]'

func GitLogMakeWindow(title)
  exec "edit" a:title
  setlocal filetype=gitlog
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal buflisted
  setlocal noswapfile
  setlocal nowrap
  "setlocal readonly
endfunc

func GitLogUpdate()
  "setlocal modifiable
  %d _
  exec "0r!git-log.sh --log 6 --log-submodule 4"
  normal 1G
  "setlocal nomodifiable
endfunc

func GitLogSyntax()
  " syntax for git log
  syn match myDir            "\[\f\+\]"
  syn match myBranch         "(.*)" contains=myHead
  syn match myHead           "HEAD" contained containedin=myBranch
  syn match myGitInfo        "\* \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ " contains=myCommit,myDate,myTime,myAuthor
  syn match myCommit         "\* \+\x\+ " contained containedin=myGitInfo
  syn match myDate           "\<\d\+/\d\+/\d\+\>" contained containedin=myGitInfo
  syn match myTime           "\<\d\+:\d\+\>" contained containedin=myGitInfo
  syn match myAuthor         " \w\+ " contained containedin=myGitInfo

  " highlight for git log
  hi link myDir              MyAqua
  hi link myBranch           MyYellow
  hi link myHead             MyPurple
  hi link myGitInfo          MyOrange
  hi link myCommit           MyRed
  hi link myDate             MyGreen
  hi link myTime             MyGreen
  hi link myAuthor           MyBlue

  " syntax for git status
  syn match myStageModify    "^MM"
  syn match myStage          "^M "
  syn match myModify         "^ M"
  syn match mySubmodule      "^ m"
  syn match myUntrack        "^??"

  " highlight for git status
  hi link myStageModify      MyAqua
  hi link myStage            MyGreen
  hi link myModify           MyRed
  hi link mySubmodule        MyYellow
  hi link myUntrack          MyBlue
endfunc

func GitLogMap()
  nnoremap <buffer> <C-R>   :call GitLogUpdate()<CR>
  nnoremap <buffer> <C-S>   :tabedit +MyGstatusToggle<CR>
  nnoremap <buffer> <C-V>   :tabedit +MyGV<CR>
endfunc

"------------------------------------------------------
" public func
"------------------------------------------------------
func GitLog(...)
  if a:0 == 0
    let dir = getcwd()
  else
    let dir = a:1
  endif
  exec "lcd" dir

  let title = s:gitlog_winname." ".dir
  call GitLogMakeWindow(title)
  call GitLogUpdate()
endfunc

func GitLogFileType()
  call GitLogSyntax()
  call GitLogMap()
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command -nargs=? -complete=dir GitLog call GitLog(<f-args>)

autocmd FileType gitlog    call GitLogFileType()

