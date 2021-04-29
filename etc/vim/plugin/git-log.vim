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

func GitLogHelp()
  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [All] [Help]\n"
  let text = text."\n"
  let text = text."GitLog\n"
  let text = text."\n"
  let text = text."<c-a> ... All\n"
  let text = text."<c-r> ... Redraw\n"
  let text = text."<c-s> ... Gstatus\n"
  let text = text."<c-v> ... GV\n"

  silent 0put =text
endfunc

func GitLogAction(fname)
  if (line(".") == 1)
    if (a:fname == "HEAD")
      call GitLogUpdate("")
    elseif (a:fname == "All")
      call GitLogUpdate("--all")
    elseif (a:fname == "Help")
      call GitLogHelp()
    elseif (a:fname == "Gstatus")
      tabedit +MyGstatusToggle
    elseif (a:fname == "GV")
      tabedit +MyGV
    endif
  endif
endfunc

func GitLogClear()
  silent %d _
endfunc

func GitLogUpdate(opts)
  "setlocal modifiable

  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [All] [Gstatus] [GV] [Help]\n"
  let text = text."\n"
  0put =text

  exec "r!git-log.sh --log 6 --log-submodule 4" a:opts
  normal 1G

  "setlocal nomodifiable
endfunc

func GitLogSyntax()
  " syntax for git log
  syn match myButton         "\[\f\+\]"
  syn match myDir            "=\+ \[\f\+\] =\+"
  syn match myBranch         "(.*)" contains=myHead
  syn match myHead           "HEAD" contained containedin=myBranch
  syn match myGitInfo        "\* \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ " contains=myCommit,myDate,myTime,myAuthor
  syn match myCommit         "\* \+\x\+ " contained containedin=myGitInfo
  syn match myDate           "\<\d\+/\d\+/\d\+\>" contained containedin=myGitInfo
  syn match myTime           "\<\d\+:\d\+\>" contained containedin=myGitInfo
  syn match myAuthor         " \w\+ " contained containedin=myGitInfo

  " highlight for git log
  hi link myButton           MyOrange
  hi link myDir              MyAqua
  hi link myBranch           MyYellow
  hi link myHead             MyPurple
  hi link myGitInfo          MyOrange
  hi link myCommit           MyRed
  hi link myDate             MyGreen
  hi link myTime             MyGreen
  hi link myAuthor           MyBlue

  " syntax for git status
  syn match myStage          "^M "
  syn match myStageModify    "^MM"
  syn match myModify         "^ M"
  syn match mySubmodule      "^ m"
  syn match myUntrack        "^??"

  " highlight for git status
  hi link myStage            MyGreen
  hi link myStageModify      MyOrange
  hi link myModify           MyRed
  hi link mySubmodule        MyYellow
  hi link myUntrack          MyBlue
endfunc

func GitLogMap()
  nnoremap <buffer> <C-R>   :call GitLogUpdate("")<CR>
  nnoremap <buffer> <C-A>   :call GitLogUpdate("--all")<CR>
  nnoremap <buffer> <C-S>   :tabedit +MyGstatusToggle<CR>
  nnoremap <buffer> <C-V>   :tabedit +MyGV<CR>
  nnoremap <buffer> <silent> <CR> :call GitLogAction(expand("<cfile>"))<CR>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
  nnoremap <buffer> <silent> ? :call GitLogHelp()<CR>
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
  call GitLogUpdate("")
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

