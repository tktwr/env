"======================================================
" func & command
"======================================================
"------------------------------------------------------
" func
"------------------------------------------------------
func s:MyGrep(args)
  lcd %:h
  silent exec "vimgrep ".a:args
endfunc

func s:MyGrepHere(args)
  lcd %:h
  silent exec "vimgrep <cword> ".a:args
endfunc

"func s:MyGrep(word)
"  silent exec "vimgrep ".a:word." **/*.hpp **/*.hxx **/*.h **/*.cpp **/*.cxx **/*.c **/*.py **/*.vim **/*.sh **/*.html **/*.md **/*.txt"
"endfunc

func s:MyGgrep(word)
  "Ggrep -I a:word -- ':!*.dat'
  exec "Ggrep -I" a:word
endfunc

func s:MyGgrepHere()
  "Ggrep -I <cword> -- ':!*.dat'
  Ggrep -I <cword>
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

func s:MySourceVimrc()
  source ~/.vimrc
endfunc

"------------------------------------------------------
" command
"------------------------------------------------------
command -nargs=+ MyGrep      call s:MyGrep("<args>")
command -nargs=+ MyGrepHere  call s:MyGrepHere("<args>")
command -nargs=+ MyGgrep     call s:MyGgrep("<args>")
command -nargs=0 MyGgrepHere call s:MyGgrepHere()

command -nargs=1 MySetTab    call s:MySetTab("<args>")
command MyLineNumberToggle   call s:MyLineNumberToggle()
command MyCheckEnv           call s:MyCheckEnv()

command MySourceVimrc        call s:MySourceVimrc()

" apply the command to each entry in the quickfix list
command MyCdo      cdo execute "normal! @q" | w
" apply the command to each file in the quickfix list
command MyCfdo     cfdo execute "normal! @q" | w

command MyTabBar             Tabularize /|
command MyTabDots            Tabularize /\.\.\.
command MyTabComma           Tabularize /,

command MyCdHere             cd %:h
command MyTcdHere            tcd %:h
command MyLcdHere            lcd %:h

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

"------------------------------------------------------
" coc
"------------------------------------------------------
func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-python coc-clangd coc-snippets coc-lists
endfunc

command MyCocInstall     call s:MyCocInstall()

