"======================================================
" func & command
"======================================================
"------------------------------------------------------
" func
"------------------------------------------------------
func s:Trans()
  exec "bot term ++rows=".g:my_trans_winheight." ++close trans -I -b"
endfunc

func s:Dict()
  exec "bot term ++rows=".g:my_trans_winheight." ++close trans -I"
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
command MyRedraw call MyRedraw()

command Trans              call s:Trans()
command Dict               call s:Dict()
command -nargs=1 MySetTab  call s:MySetTab("<args>")
command MyLineNumberToggle call s:MyLineNumberToggle()
command MyCheckEnv         call s:MyCheckEnv()

command -nargs=+ VimGrep   call s:MyVimGrep("<args>")
command VimGrepHere        VimGrep <cword>

command GgrepHere          Ggrep -I <cword> -- ':!*.dat'

" apply the command to each entry in the quickfix list
command Cdo      cdo execute "normal! @q" | w
" apply the command to each file in the quickfix list
command Cfdo     cfdo execute "normal! @q" | w

command RunExplorer        silent !explorer.exe %:h
command RunGvim            silent !gvim "%"
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"

command TabBar             Tabularize /|
command TabDots            Tabularize /\.\.\.
command TabComma           Tabularize /,

command MyCdHere           cd %:h
command MyLcdHere          lcd %:h

command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

"------------------------------------------------------
" coc
"------------------------------------------------------
func s:MyCocInstall()
  CocInstall coc-tsserver coc-json coc-python coc-clangd coc-snippets coc-lists
endfunc

command MyCocInstall     call s:MyCocInstall()

