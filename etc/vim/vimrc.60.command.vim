"======================================================
" func & command
"======================================================
"------------------------------------------------------
" source
"------------------------------------------------------
if !exists("g:my_source_vimrc")
  let g:my_source_vimrc = 1
  func s:MySourceVimrc()
    source ~/.vimrc
  endfunc
  command MySourceVimrc        call s:MySourceVimrc()
endif

"------------------------------------------------------
" func
"------------------------------------------------------
func s:MyVimgrep(args)
  lcd %:h
  silent exec "vimgrep ".a:args
endfunc

func s:MyVimgrepHere(args)
  lcd %:h
  silent exec "vimgrep <cword> ".a:args
endfunc

"func s:MyVimgrep(word)
"  silent exec "vimgrep ".a:word." **/*.hpp **/*.hxx **/*.h **/*.cpp **/*.cxx **/*.c **/*.py **/*.vim **/*.sh **/*.html **/*.md **/*.txt"
"endfunc

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
command -nargs=+ MyVimgrep      call s:MyVimgrep("<args>")
command -nargs=+ MyVimgrepHere  call s:MyVimgrepHere("<args>")

command -nargs=1 MySetTab    call s:MySetTab("<args>")
command MyLineNumberToggle   call s:MyLineNumberToggle()
command MyCheckEnv           call s:MyCheckEnv()

" apply the command to each entry in the quickfix list
command MyCdo      cdo execute "normal! @q" | w
" apply the command to each file in the quickfix list
command MyCfdo     cfdo execute "normal! @q" | w

command MyCdHere             exec "cd"  expand("%:p:h")
command MyTcdHere            exec "tcd" expand("%:p:h")
command MyLcdHere            exec "lcd" expand("%:p:h")

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

