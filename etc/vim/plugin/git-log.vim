"======================================================
" GitLog
"======================================================
if exists("loaded_gitlog")
  finish
endif

let loaded_gitlog = 1
let s:gitlog_winname = '\[gitlog\]'

func GitLogClear()
  silent %d _
endfunc

func GitLogToggleHelp()
  let w:help = !w:help
  if (w:help)
    call GitLogHelp()
  else
    call GitLogUpdate("")
  endif
endfunc

func GitLogHelp()
  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [All] [Help(?)]\n"
  let text = text."\n"
  let text = text."GitLog\n"
  let text = text."\n"
  let text = text."<c-a> ... All\n"
  let text = text."<c-r> ... Redraw\n"
  let text = text."<c-s> ... Gstatus\n"
  let text = text."<c-v> ... GV\n"

  silent 0put =text
endfunc

func GitLogUpdate(opts)
  "setlocal modifiable

  call GitLogClear()

  let text = ""
  let text = text.b:dir."\n"
  let text = text."[HEAD] [All] [Status] [Fetch] [Graph] [Help(?)]\n"
  let text = text."\n"
  silent 0put =text

  silent exec "r!git-log.sh --log 6 --log-submodule 4" a:opts
  normal 1G

  "setlocal nomodifiable
endfunc

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

func GitLogAction(fname)
  if (line(".") == 2)
    if (a:fname == "HEAD")
      Git fetch
      call GitLogUpdate("")
    elseif (a:fname == "All")
      Git fetch
      call GitLogUpdate("--all")
    elseif (a:fname == "Status")
      tabedit +MyGstatusToggle
    elseif (a:fname == "Fetch")
      Git fetch
    elseif (a:fname == "Graph")
      tabedit +MyGV
    elseif (a:fname == "Help")
      call GitLogToggleHelp()
    endif
  endif
endfunc

func GitLogMap()
  nnoremap <buffer> <silent> <C-R>  :call GitLogUpdate("")<CR>
  nnoremap <buffer> <silent> <C-A>  :call GitLogUpdate("--all")<CR>
  nnoremap <buffer> <silent> <C-S>  :tabedit +MyGstatusToggle<CR>
  nnoremap <buffer> <silent> <C-V>  :tabedit +MyGV<CR>
  nnoremap <buffer> <silent> <CR>   :call GitLogAction(expand("<cword>"))<CR>
  nnoremap <buffer> <silent> l      W
  nnoremap <buffer> <silent> h      B
  nnoremap <buffer> <silent> ?      :call GitLogToggleHelp()<CR>
endfunc

func GitLogSyntax()
  " syntax for git log
  syn match myButton         "\[.\+\]"
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
  let b:dir = dir
  call GitLogUpdate("")
  let w:help = 0
endfunc

func GitLogFileType()
  call GitLogMap()
  call GitLogSyntax()
endfunc

func GitLogBufEnter()
  if &filetype != "gitlog"
    return
  endif

  exec "lcd" b:dir
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command -nargs=? -complete=dir GitLog call GitLog(<f-args>)

augroup gitlog
  autocmd!
  autocmd FileType gitlog  call GitLogFileType()
  autocmd BufEnter *       call GitLogBufEnter()
augroup END

