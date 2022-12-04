"------------------------------------------------------
" Menu
"------------------------------------------------------
"aunmenu *
"source $VIMRUNTIME/menu.vim
source $MY_VIM/menu.vim
set wildmenu
set cpo-=<
set wcm=<C-Z>
"map <C-Down> :emenu <C-Z>

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

command MyEditAltSrc       call s:MyEditAltSrc()

"------------------------------------------------------
func s:MySetJapanese()
  " encoding
  set fileencodings=japan
  set termencoding=japan
endfunc

command JP       call s:MySetJapanese()

"------------------------------------------------------
command -nargs=* -complete=file MyVspRight rightbelow vsplit <args>

command RunExplorer        silent !explorer.sh %:h
command RunVscode          silent !vscode.sh "%"
command RunChrome          silent !chrome.sh "%"
command RunFirefox         silent !firefox "%"
command RunGvim            silent !gvim "%"

"------------------------------------------------------
" edit.autocmd
"------------------------------------------------------
" update the line started with "[LastChange]"
func s:MyUpdateLastChange()
  normal m'
  let l:nr = search('\[LastChange\]')
  if (l:nr != 0)
    let l:cmd = "env LC_TIME=C date"
    let l:str = s:MySystem(l:cmd)
    call setline('.', "[LastChange] ".l:str)
  endif
  normal `'
endfunc

command MyUpdateLastChange       call s:MyUpdateLastChange()

augroup ag_my_edit
  autocmd!
  autocmd BufWritePre,FileWritePre *.html  MyUpdateLastChange
  autocmd BufWritePre,FileWritePre *.txt   MyUpdateLastChange
augroup END

