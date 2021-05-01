"======================================================
" GitLog
"======================================================
if exists("loaded_gitlog")
  finish
endif

let loaded_gitlog = 1
let s:gitlog_winname = '\[gitlog\]'
let s:gitlog_log = {}
let s:gitlog_status = {}

"------------------------------------------------------
" private func
"------------------------------------------------------
func GitLogClear()
  silent %d _
endfunc

func GitLogApply()
  normal 1G
  let start = search('---')
  let end = search('---')
  let lines = getline(start+1, end-1)
  for line in lines
    exec line
  endfor
endfunc

func GitLogToggleHelp()
  let b:help = !b:help
  if (b:help)
    call GitLogHelp()
  else
    call GitLogUpdate("")
  endif
endfunc

"------------------------------------------------------
" display
"------------------------------------------------------
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

func GitLogSetting()
  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [Apply] [Help]\n"
  let text = text."\n"
  let text = text."GitLog:Setting\n"
  let text = text."\n"
  let text = text."---\n"
  let text = text."let b:base_dir = \"".b:base_dir."\"\n"
  let text = text."let b:log = ".b:log."\n"
  let text = text."let b:log_submodule = ".b:log_submodule."\n"
  let text = text."---\n"

  silent 0put =text
endfunc

func GitLogLines(text)
  return split(a:text, '\n')
endfunc

func GitLogColumn(text, num)
  let words = []
  let lines = split(a:text, '\n')
  for line in lines
    let words += [split(line)[a:num]]
  endfor
  return words
endfunc

func GitLogLog(dir, opts)
  call GitLogPut("<".a:dir.">")
  exec "lcd" a:dir

  let log_cmd = "Git graph ".a:opts
  let log = system(log_cmd)
  let status = system("Git status -s")

  call GitLogPut("[Graph]")
  call GitLogPut(log)
  call GitLogPut("[Status]")
  call GitLogPut(status)

  let s:gitlog_log[a:dir] = log
  let s:gitlog_status[a:dir] = status
endfunc

func GitLogLogSubmodule(base_dir, opts)
  let out = system("git submodule")
  let lines = GitLogLines(out)
  for line in lines
    exec "lcd" a:base_dir
    let lst = split(line)
    let commit = lst[0]
    let subdir = lst[1]

    if (commit[0] == '+')
      let out = system("git diff --submodule ".subdir)
      let out_lines = GitLogLines(out)
      call GitLogPut(out_lines[0])
    endif

    let dir = a:base_dir."/".subdir
    call GitLogLog(dir, a:opts)
  endfor
endfunc

func GitLogPut0(text)
  silent 0put =a:text
endfunc

func GitLogPut(text)
  silent put =a:text
endfunc

func GitLogUpdate(opts)
  "setlocal modifiable

  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [All] [Setting] [Help]\n"
  let text = text."\n"

  call GitLogPut0(text)

  let opts = "-".b:log." ".a:opts
  call GitLogLog(b:base_dir, opts)

  if (b:log_submodule > 0)
    call GitLogPut("\n")
    call GitLogPut("--- Submodules ---")

    let opts = "-".b:log_submodule." ".a:opts
    call GitLogLogSubmodule(b:base_dir, opts)
  endif

  normal 1G

  "setlocal nomodifiable
endfunc

"------------------------------------------------------
" window
"------------------------------------------------------
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

"------------------------------------------------------
" action
"------------------------------------------------------
func GitLogLcd()
  let l = search('^<', 'b')
  let dir = expand('<cfile>')
  exec "lcd" dir
endfunc

func GitLogAction(word)
  if (getline(".")[0] == "[")
    if (a:word == "HEAD")
      Git fetch
      call GitLogUpdate("")
    elseif (a:word == "All")
      Git fetch
      call GitLogUpdate("--all")
    elseif (a:word == "Fetch")
      Git fetch
    elseif (a:word == "Status")
      call GitLogLcd()
      tabedit +MyGstatusToggle
    elseif (a:word == "Graph")
      call GitLogLcd()
      tabedit +MyGV
    elseif (a:word == "Setting")
      call GitLogSetting()
    elseif (a:word == "Apply")
      call GitLogApply()
      Git fetch
      call GitLogUpdate("")
    elseif (a:word == "Help")
      call GitLogToggleHelp()
    endif
  endif
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func GitLogMap()
  nnoremap <buffer> <silent> <CR>   :call GitLogAction(expand("<cword>"))<CR>
  nnoremap <buffer> <silent> <C-N>  :call search('\[')<CR>
  nnoremap <buffer> <silent> <C-P>  :call search('\[', 'b')<CR>
endfunc

"------------------------------------------------------
" syntax
"------------------------------------------------------
func GitLogSyntax()
  " syntax for git log
  syn match gitlogButton         "\[.\+\]"
  syn match gitlogDir            "<\f\+>"
  syn match gitlogBranch         "(.*)" contains=gitlogHead
  syn match gitlogHead           "HEAD" contained containedin=gitlogBranch
  syn match gitlogGitInfo        "\* \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ \+[^ ]\+ " contains=gitlogCommit,gitlogDate,gitlogTime,gitlogAuthor
  syn match gitlogCommit         "\* \+\x\+ " contained containedin=gitlogGitInfo
  syn match gitlogDate           "\<\d\+/\d\+/\d\+\>" contained containedin=gitlogGitInfo
  syn match gitlogTime           "\<\d\+:\d\+\>" contained containedin=gitlogGitInfo
  syn match gitlogAuthor         " \w\+ " contained containedin=gitlogGitInfo

  " highlight for git log
  hi link gitlogButton           MyAqua
  hi link gitlogDir              MyPurple
  hi link gitlogBranch           MyYellow
  hi link gitlogHead             MyPurple
  hi link gitlogGitInfo          MyOrange
  hi link gitlogCommit           MyRed
  hi link gitlogDate             MyGreen
  hi link gitlogTime             MyGreen
  hi link gitlogAuthor           MyBlue

  " syntax for git status
  syn match gitlogStage          "^M "
  syn match gitlogStageModify    "^MM"
  syn match gitlogModify         "^ M"
  syn match gitlogSubmodule      "^ m"
  syn match gitlogUntrack        "^??"

  " highlight for git status
  hi link gitlogStage            MyGreen
  hi link gitlogStageModify      MyOrange
  hi link gitlogModify           MyRed
  hi link gitlogSubmodule        MyYellow
  hi link gitlogUntrack          MyBlue
endfunc

"------------------------------------------------------
" public command
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
  let b:base_dir = dir
  let b:help = 0
  let b:log = 6
  let b:log_submodule = 4
  call GitLogUpdate("")
endfunc

command -nargs=? -complete=dir GitLog call GitLog(<f-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func GitLogFileType()
  call GitLogSyntax()
endfunc

func GitLogBufEnter()
  if &filetype != "gitlog"
    return
  endif

  exec "lcd" b:base_dir
  call GitLogMap()
endfunc

augroup gitlog
  autocmd!
  autocmd FileType gitlog  call GitLogFileType()
  autocmd BufEnter *       call GitLogBufEnter()
augroup END

