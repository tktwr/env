"======================================================
" GitLog
"======================================================
if exists("g:loaded_gitlog")
  finish
endif
let g:loaded_gitlog = 1

let s:gitlog_winname = '\[gitlog\]'
let s:gitlog_log = {}
let s:gitlog_status = {}
let s:prev_screen = ""

"------------------------------------------------------
" private func
"------------------------------------------------------
func GitLogClear()
  silent %d _
endfunc

func GitLogPut0(text)
  silent 0put =a:text
endfunc

func GitLogPut(text)
  silent put =a:text
endfunc

func GitLogStoreBuf()
  normal 1GyG
  let s:prev_screen = @"
endfunc

func GitLogRestoreBuf()
  call GitLogClear()
  silent 0put =s:prev_screen
endfunc

func GitLogLines(text)
  return split(a:text, '\n')
endfunc

func GitLogColumns(text, num)
  let words = []
  let lines = split(a:text, '\n')
  for line in lines
    let words += [split(line)[a:num]]
  endfor
  return words
endfunc

"------------------------------------------------------
" display
"------------------------------------------------------
func GitLogHelp()
  call GitLogClear()

  let text = ""
  let text = text."[Back]\n"
  let text = text."\n"
  let text = text."GitLog:Help\n"
  let text = text."\n"
  let text = text."<CR>  ... action\n"
  let text = text."<C-R> ... redraw\n"
  let text = text."<C-A> ... all\n"
  let text = text."<C-N> ... next button\n"
  let text = text."<C-P> ... prev button\n"
  let text = text."S     ... setting\n"
  let text = text."?     ... help\n"

  silent 0put =text
endfunc

func GitLogToggleHelp()
  let b:help = !b:help
  if (b:help)
    call GitLogStoreBuf()
    call GitLogHelp()
  else
    call GitLogRestoreBuf()
  endif
endfunc

func GitLogSetting()
  call GitLogClear()

  let text = ""
  let text = text."[Back] [Apply]\n"
  let text = text."\n"
  let text = text."GitLog:Setting\n"
  let text = text."\n"
  let text = text."---\n"
  let text = text."let b:base_dir = \"".b:base_dir."\"\n"
  let text = text."let b:log = ".b:log."\n"
  let text = text."let b:log_submodule = ".b:log_submodule."\n"
  let text = text."let b:log_all = \"".b:log_all."\"\n"
  let text = text."---\n"

  silent 0put =text
endfunc

func GitLogToggleSetting()
  let b:setting = !b:setting
  if (b:setting)
    call GitLogStoreBuf()
    call GitLogSetting()
  else
    call GitLogRestoreBuf()
  endif
endfunc

"------------------------------------------------------
" log
"------------------------------------------------------
func GitLogLog(dir, opts)
  call GitLogPut("<".a:dir.">")
  exec "lcd" a:dir

  let log_cmd = "git graph ".a:opts
  let log = system(log_cmd)
  let status = system("git status -s")

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
  let n_lines = len(lines)

  if (n_lines > 0)
    call GitLogPut("\n")
    call GitLogPut("--- Submodules ---")
  endif

  for line in lines
    let lst = split(line)
    let commit = lst[0]
    let subdir = lst[1]

    if (commit[0] == '+')
      exec "lcd" a:base_dir
      let diff_sm = system("git diff --submodule ".subdir)
      let diff_sm_lines = GitLogLines(diff_sm)
      call GitLogPut(diff_sm_lines[0])
    endif

    let dir = a:base_dir."/".subdir
    call GitLogLog(dir, a:opts)
  endfor
  exec "lcd" a:base_dir
endfunc

func GitLogUpdate(opts)
  "setlocal modifiable

  call GitLogClear()

  let text = ""
  let text = text."[HEAD] [All] [Setting] [Help]\n"
  let text = text."\n"

  call GitLogPut0(text)

  let opts = b:log_all." -".b:log." ".a:opts
  call GitLogLog(b:base_dir, opts)

  if (b:log_submodule > 0)
    let opts = b:log_all." -".b:log_submodule." ".a:opts
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
func GitLogFetch()
  exec "lcd" b:base_dir
  Git fetch
endfunc

func GitLogLcd()
  let l = search('^<', 'b')
  let dir = expand('<cfile>')
  exec "lcd" dir
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

func GitLogAction(word)
  if (a:word == "HEAD")
    let b:log_all = ""
    call GitLogFetch()
    call GitLogUpdate("")
  elseif (a:word == "All")
    let b:log_all = "--all"
    call GitLogFetch()
    call GitLogUpdate("")
  elseif (a:word == "Apply")
    call GitLogApply()
    call GitLogUpdate("")
  elseif (a:word == "Graph")
    call GitLogLcd()
    tabedit +MyGV
  elseif (a:word == "Status")
    call GitLogLcd()
    tabedit +MyGstatusToggle
  elseif (a:word == "Setting")
    call GitLogStoreBuf()
    call GitLogSetting()
  elseif (a:word == "Help")
    call GitLogStoreBuf()
    call GitLogHelp()
  elseif (a:word == "Back")
    call GitLogRestoreBuf()
  endif
endfunc

"------------------------------------------------------
" map
"------------------------------------------------------
func GitLogMap()
  nnoremap <buffer> <silent> <CR>   :call GitLogAction(expand("<cword>"))<CR>
  nnoremap <buffer> <silent> <C-R>  :call GitLogAction("HEAD")<CR>
  nnoremap <buffer> <silent> <C-A>  :call GitLogAction("All")<CR>
  nnoremap <buffer> <silent> <C-N>  :call search('\[')<CR>
  nnoremap <buffer> <silent> <C-P>  :call search('\[', 'b')<CR>
  nnoremap <buffer> <silent> S      :call GitLogToggleSetting()<CR>
  nnoremap <buffer> <silent> ?      :call GitLogToggleHelp()<CR>
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

  let title = s:gitlog_winname." ".dir
  call GitLogMakeWindow(title)

  let b:help = 0
  let b:setting = 0
  let b:base_dir = dir
  let b:log = 6
  let b:log_submodule = 4
  let b:log_all = ""
  call GitLogUpdate("")
endfunc

command -nargs=? -complete=dir GitLog call GitLog(<f-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func GitLogStatusline()
  let l:statusline = "%{TtStatuslineWinNr()}"
  let l:statusline.= "\ [gitlog]"
  let l:statusline.= "\ %=%{MyCWD()}"
  return l:statusline
endfunc

func GitLogFileType()
  call GitLogSyntax()
  setl statusline=%!GitLogStatusline()
endfunc

func GitLogBufEnter()
  if &filetype != "gitlog"
    return
  endif

  exec "lcd" b:base_dir
  call GitLogMap()
endfunc

augroup ag_gitlog
  autocmd!
  autocmd FileType gitlog  call GitLogFileType()
  autocmd BufEnter *       call GitLogBufEnter()
augroup END

