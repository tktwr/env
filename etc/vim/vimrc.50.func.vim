"======================================================
" func
"======================================================

func MyOpenURL(url)
  let l:url = expand(a:url)
  if (l:url == "")
    let l:url = expand("<cfile>")
    "let l:url = getline('.')
  endif
  exec "silent !chrome.sh" l:url
  redraw!
endfunc

func MyOpenDir(url)
  let l:url = expand(a:url)
  if (l:url == "")
    let l:url = expand("<cfile>")
    "let l:url = getline('.')
  endif
  exec "silent !explorer.sh" l:url
  redraw!
endfunc

func MyOpenNERDTree(url)
  let l:url = expand(a:url)
  if (l:url == "")
    let l:url = expand("<cfile>")
    "let l:url = getline('.')
  endif
  exec "silent NERDTree" l:url
  redraw!
endfunc

func s:Trans()
  bot term ++rows=10 ++close trans -I -b
endfunc

func s:MyVimGrep(word)
  silent exec "vimgrep ".a:word." **/*.hpp **/*.hxx **/*.h **/*.cpp **/*.cxx **/*.c **/*.py **/*.vim **/*.sh **/*.html **/*.md **/*.txt"
endfunc

func s:MySetTab(nr)
  let &tabstop=a:nr
  let &shiftwidth=a:nr
endfunc

func s:MyLineNumberToggle()
  set invnumber
  set invlist
endfunc

func s:MyCheckEnv()
  echo "version: ".v:version
  echo "unix: ".has("unix")
  echo "win32unix: ".has("win32unix")
  echo "win32: ".has("win32")
  echo "win64: ".has("win64")
  echo "python: ".has("python")
  if has("python")
    py print(sys.version)
  endif
  echo "python3: ".has("python3")
  if has("python3")
    py3 print(sys.version)
  endif
  echo "gui_running: ".has("gui_running")
  echo "term: ".&term
  echo "shell: ".&shell
  echo "path: ".&path
  echo "runtimepath: ".&runtimepath
  echo "pwd:"
  pwd
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------

command Trans              call s:Trans()
command -nargs=+ VimGrep   call s:MyVimGrep("<args>")
command VimGrepHere        VimGrep <cword>
command -nargs=1 MySetTab  call s:MySetTab("<args>")
command MyLineNumberToggle call s:MyLineNumberToggle()
command MyCheckEnv         call s:MyCheckEnv()

