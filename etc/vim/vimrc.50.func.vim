"======================================================
" func
"======================================================

func s:ClangFormat()
  !clang-format -i %
endfunc

func s:Trans()
  bot term ++rows=10 ++close trans -I -b
endfunc

func s:MyDia(sp, type)
  let l:dia = "$MY_DIARY/diary.md.html"
  let l:todo = "$MY_DIARY/todo.md.html"

  if a:type == 'd'
    exec a:sp l:dia
  elseif a:type == 't'
    exec a:sp l:todo
  elseif a:type == 'h'
    exec a:sp l:todo
    exec "sp" l:dia
    wincmd j
    resize 10
    wincmd k
  elseif a:type == 'v'
    exec a:sp l:todo
    exec "vsp" l:dia
    wincmd l
    vertical resize 40
    wincmd h
  endif
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

func s:MyIDE()
  NERDTree
  wincmd l
  Tagbar
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
" func: dev
"------------------------------------------------------

func s:MyEditAltSrc()
  let ext = expand("%:e")
  if (ext == "c" || ext == "cxx" || ext == "cpp")
    let fname = expand("%:r") . ".h"
  elseif (ext == "h")
    let fname = expand("%:r") . ".cpp"
  endif
  exec "edit" fname
endfunc

func s:MyStartProf()
  profile start prof.txt
  profile func *
  profile file *
endfunc

func s:MyEndProf()
  profile pause
  noautocmd qall!
endfunc

"------------------------------------------------------
" func: diff
"------------------------------------------------------

set diffopt=filler,vertical,iwhite

func s:MySetDiffMode()
  if &diff
    nnoremap <buffer> <C-P>   [c
    nnoremap <buffer> <C-N>   ]c
    nnoremap <buffer> <C-X>   :tabclose<CR>
  endif
endfunc

"------------------------------------------------------
" func: encoding
"------------------------------------------------------
func s:MySetJapanese()
  " encoding
  set fileencodings=japan
  set termencoding=japan
endfunc

