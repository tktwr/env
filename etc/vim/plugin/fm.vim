"--------------------------------------------------------------------------
" Vim global plugin
" Description: file manager
" Last Change: 2018 Apr 22
" Maintainer:  Takehiro Tawara
"--------------------------------------------------------------------------
if exists("loaded_fm")
  finish
endif

let loaded_fm = 1
let g:fm_encoding = 'euc-jp'
let s:fm_winname = '\[fm\]'

let g:fm_cmd = ""
let s:fm_cmd_doc = "ooffice"
let s:fm_cmd_pdf = "chrome"
let s:fm_cmd_png = "chrome"
let s:fm_cmd_jpg = "chrome"
let s:fm_cmd_obj = "meshlab"
let s:fm_cmd_stl = "meshlab"

"--------------------------------------------------------------------------
" s:PrintHelp()
"--------------------------------------------------------------------------
func! s:PrintHelp()
  let text = "Fm - Vim global plugin to manage files\n"
  let text = text."\n"
  let text = text."Commands:\n"
  let text = text."  o ............... open a directory\n"
  let text = text."  <Enter>\n"
  let text = text."  <LeftMouse>\n"
  let text = text."  u ............... go to the parent directory\n"
  let text = text."  <RightMouse>\n"
  let text = text."  e ............... edit a file\n"
  let text = text."  s ............... edit a file in a splitted window\n"
  let text = text."  x ............... execute\n"
  let text = text."  <2-LeftMouse>\n"
  let text = text."  L ............... toggle the list mode\n"
  let text = text."  ? ............... toggle this help\n"
  let text = text."  q ............... close the window\n"

  setlocal modifiable
  silent %d _
  silent 0put =text
  setlocal nomodifiable
endfunc

"--------------------------------------------------------------------------
" s:Open(fname)
"--------------------------------------------------------------------------
func! s:Open(fname)
  if (line(".") == 2)
    if (a:fname == "Home")
      call s:CmdCd("")
      return
    endif
    if (a:fname == "List")
      call s:ToggleList()
      return
    endif
    if (a:fname == "Help")
      call s:ToggleHelp()
      return
    endif
  endif
  if isdirectory(a:fname)
    call s:CmdCd(a:fname)
    return
  endif
  if filereadable(a:fname)
    call s:Exec()
  endif
endfunc

"--------------------------------------------------------------------------
" s:Exec()
"--------------------------------------------------------------------------
func! s:Exec()
  if g:fm_cmd != ""
    let cmd = g:fm_cmd
  else
    let ext = expand("<cfile>:e")
    let cmd = s:fm_cmd_{ext}
  endif
  silent exec "!" cmd expand("<cfile>") "&"
endfunc

"--------------------------------------------------------------------------
" s:CmdLs(dir)
"--------------------------------------------------------------------------
func! s:CmdLs(dir)
  setlocal modifiable
  silent %d _
  let text = "[".getcwd()."]"
  0put =text
  let text = "../    [Home] [List] [Help]"
  put =text

  if (w:col == 1)
    let opt2 = "-vCF -w ".s:cols
  else
    let opt2 = "-vlF"
  endif

  silent exec "r!ls" opt2 a:dir

  if (w:col == 1)
    normal 3G
  else
    normal 4G$B
  endif
  setlocal nomodifiable
endfunc

"--------------------------------------------------------------------------
" s:CmdCd(dir)
"--------------------------------------------------------------------------
func! s:CmdCd(dir)
  silent exec "lcd" a:dir
  call s:CmdLs("")
endfunc

"--------------------------------------------------------------------------
" s:ToggleHelp()
"--------------------------------------------------------------------------
func! s:ToggleHelp()
  let w:help = !w:help
  if (w:help)
    call s:PrintHelp()
  else
    call s:CmdLs("")
  endif
endfunc

"--------------------------------------------------------------------------
" s:ToggleList()
"--------------------------------------------------------------------------
func! s:ToggleList()
  let w:col = !w:col
  call s:CmdLs("")
endfunc

"--------------------------------------------------------------------------
" s:DefineCommands()
" define commands used in the [fm] window
"--------------------------------------------------------------------------
func! s:DefineCommands()
  nnoremap <buffer> <silent> o :call <SID>Open(expand("<cfile>"))<CR>
  nnoremap <buffer> <silent> <CR> :call <SID>Open(expand("<cfile>"))<CR>
  nnoremap <buffer> <silent> <LeftMouse> <LeftMouse>:call <SID>Open(expand("<cfile>"))<CR>
  nnoremap <buffer> <silent> u :call <SID>Open("..")<CR>
  nnoremap <buffer> <silent> <RightMouse> :call <SID>Open("..")<CR>
  nnoremap <buffer> <silent> x :call <SID>Exec()<CR>
  nnoremap <buffer> <silent> <2-LeftMouse> :call <SID>Exec()<CR>
  nnoremap <buffer> <silent> e gf
  nnoremap <buffer> <silent> s <C-W><C-F>
  nnoremap <buffer> <silent> l W
  nnoremap <buffer> <silent> h B
  nnoremap <buffer> <silent> L :call <SID>ToggleList()<CR>
  nnoremap <buffer> <silent> ? :call <SID>ToggleHelp()<CR>
  nnoremap <buffer> <silent> q :pclose<CR>
  syn match fexplorerDirectory "\f*/"
  syn match fexplorerSpecial "\[\f*\]"
  hi link fexplorerDirectory Directory
  hi link fexplorerSpecial Special
endfunc

"--------------------------------------------------------------------------
" Fm(cmd, dir)
"--------------------------------------------------------------------------
func! Fm(cmd, dir)
  " make a [fm] window
  let s:fm_winnr = bufwinnr(s:fm_winname)
  if s:fm_winnr == -1
    silent exec "edit" s:fm_winname
    "silent exec "setlocal fileencodings=".g:fm_encoding
    "silent exec "setlocal encoding=".g:fm_encoding
    setlocal buftype=nofile
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal tabstop=8
    let s:fm_winnr = bufwinnr(s:fm_winname)
    call s:DefineCommands()
    let s:cols = system("tput cols")
  endif

  let w:help = 0
  let w:col = 1

  if a:cmd == "cd"
    call s:CmdCd(a:dir)
  elseif a:cmd == "ls"
    call s:CmdLs(a:dir)
  endif

endfunc

"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------
command -nargs=* -complete=dir CD call Fm("cd", "<args>")
command -nargs=* -complete=dir LS call Fm("ls", "<args>")
command -nargs=* FmCmd let g:fm_cmd = "<args>"

