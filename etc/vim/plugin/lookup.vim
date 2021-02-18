"--------------------------------------------------------------------------
" Vim global plugin
" Description: lookup a keyword in the preview window
" Last Change: 2002 Jul 27
" Maintainer:  Takehiro Tawara
"--------------------------------------------------------------------------

if exists("loaded_lookup")
  finish
endif

let loaded_lookup = 1
let s:lookup_winname = '\[Lookup\]'
let s:lookup_winheight = 12
let s:tmpfile = tempname()

"--------------------------------------------------------------------------
" s:PrintHelp ()
"--------------------------------------------------------------------------
func! s:PrintHelp ()
  let text = "Lookup - Vim global plugin to look up a keyword\n"
  let text = text."\n"
  let text = text."Commands:\n"
  let text = text."  [1-9] ... print the Nth content\n"
  let text = text."  ? ....... toggle this help\n"
  let text = text."  q ....... close the window\n"

  setlocal modifiable
  silent 1,$d _
  silent 0put =text
  setlocal nomodifiable
endfunc

"--------------------------------------------------------------------------
" s:ToggleHelp ()
"--------------------------------------------------------------------------
func! s:ToggleHelp ()
  let s:help = !s:help
  if (s:help)
    call s:PrintHelp()
  else
    call Lookup(s:prg, s:opt, s:word)
  endif
endfunc

"--------------------------------------------------------------------------
" s:DefineCommands ()
" define commands used in the [Lookup] window
"--------------------------------------------------------------------------
func! s:DefineCommands ()
  nnoremap <buffer> <silent> 1 :call Lookup(s:prg, "-e=1", s:word)<CR>
  nnoremap <buffer> <silent> 2 :call Lookup(s:prg, "-e=2", s:word)<CR>
  nnoremap <buffer> <silent> 3 :call Lookup(s:prg, "-e=3", s:word)<CR>
  nnoremap <buffer> <silent> 4 :call Lookup(s:prg, "-e=4", s:word)<CR>
  nnoremap <buffer> <silent> 5 :call Lookup(s:prg, "-e=5", s:word)<CR>
  nnoremap <buffer> <silent> 6 :call Lookup(s:prg, "-e=6", s:word)<CR>
  nnoremap <buffer> <silent> 7 :call Lookup(s:prg, "-e=7", s:word)<CR>
  nnoremap <buffer> <silent> 8 :call Lookup(s:prg, "-e=8", s:word)<CR>
  nnoremap <buffer> <silent> 9 :call Lookup(s:prg, "-e=9", s:word)<CR>
  nnoremap <buffer> <silent> ? :call <SID>ToggleHelp()<CR>
  nnoremap <buffer> <silent> q :pclose<CR>
  "syn region   myString           start=+"+ end=+"+ skip=+\\"+
  "syn region   myItem             start=+{+ end=+}+
  "hi link myString           String
  "hi link myItem             Type
endfunc

"--------------------------------------------------------------------------
" Lookup (prg, opt, word)
"--------------------------------------------------------------------------
" remove a linefeed NL (0x0A)
func s:RemoveNL(str)
  let l:str = a:str
  let l:str = substitute(l:str, '\n', '', 'g')
  let l:str = substitute(l:str, "[\xA]", '', 'g')
  return l:str
endfunc

func! Lookup (prg, opt, word) range
  " check the window where the command is invoked
  if (!&previewwindow)
    let from_outside = 1
  else
    let from_outside = 0
  endif

  let s:help = 0

  " store arguments to window-local variables
  let s:prg = a:prg
  let s:opt = a:opt
  let s:word = expand(a:word)

  if (empty(s:word))
    silent normal gvy
    let selected = @@
    let s:word = selected
  endif

  let s:word = s:RemoveNL(s:word)
  let s:word = '\"'.s:word.'\"'

  silent botright pedit s:lookup_winname
  wincmd P
  exec "resize" s:lookup_winheight

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal modifiable

  call s:DefineCommands()

  silent exec "!" s:prg s:opt s:word ">" s:tmpfile
  silent exec "0read" s:tmpfile

  setlocal nomodifiable

  " return to the original window
  if (from_outside)
    wincmd p
  endif
endfunc

"--------------------------------------------------------------------------
" command
"--------------------------------------------------------------------------
" dictionary
command -range -nargs=+ EJ  call Lookup("ej", "", <q-args>)
command -range -nargs=+ EE  call Lookup("ee", "", <q-args>)
command -range -nargs=+ GJ  call Lookup("gj", "", <q-args>)

" dictionary
command -range -nargs=* DictJa call Lookup("trans", ":ja -w 60 -no-ansi", <q-args>)
command -range -nargs=* DictEn call Lookup("trans", ":en -w 60 -no-ansi", <q-args>)
command -range -nargs=* DictZh call Lookup("trans", ":zh -w 60 -no-ansi", <q-args>)

" translation
command -range -nargs=* TransJa call Lookup("trans", ":ja -w 60 -b", <q-args>)
command -range -nargs=* TransEn call Lookup("trans", ":en -w 60 -b", <q-args>)
command -range -nargs=* TransZh call Lookup("trans", ":zh -w 60 -b", <q-args>)

command DictJaHere     DictJa <cword>
command DictEnHere     DictEn <cword>
command DictZhHere     DictZh <cword>

command TransJaVisual  TransJa
command TransEnVisual  TransEn
command TransZhVisual  TransZh

"command TransJaVisual  TransJa "<C-R>""
"command TransEnVisual  TransEn "<C-R>""
"command TransZhVisual  TransZh "<C-R>""

"--------------------------------------------------------------------------
" map
"--------------------------------------------------------------------------
"nnoremap K    :call Lookup("ej", "", expand("<cword>"))<CR>

