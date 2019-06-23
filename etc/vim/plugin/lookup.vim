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
  let s:word = a:word

  if (empty(s:word))
    silent normal gvy
    let selected = @@
    let s:word = selected
    let s:word = substitute(s:word, '\n', ' ', 'g')
  endif

  let s:word = '"'.s:word.'"'

  silent botright pedit s:lookup_winname
  wincmd P
  resize 12

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
command -range -nargs=* Dja call Lookup("trans", ":ja -w 60 -no-ansi", <q-args>)
command -range -nargs=* Den call Lookup("trans", ":en -w 60 -no-ansi", <q-args>)
command -range -nargs=* Dzh call Lookup("trans", ":zh -w 60 -no-ansi", <q-args>)

" translation
command -range -nargs=* Tja call Lookup("trans", ":ja -w 60 -b", <q-args>)
command -range -nargs=* Ten call Lookup("trans", ":en -w 60 -b", <q-args>)
command -range -nargs=* Tzh call Lookup("trans", ":zh -w 60 -b", <q-args>)

"--------------------------------------------------------------------------
" map
"--------------------------------------------------------------------------
nnoremap K    :call Lookup("ej", "", expand("<cword>"))<CR>

nnoremap Tja  :call Lookup("trans", ":ja -w 60 -b", expand("<cword>"))<CR>
nnoremap Ten  :call Lookup("trans", ":en -w 60 -b", expand("<cword>"))<CR>
nnoremap Tzh  :call Lookup("trans", ":zh -w 60 -b", expand("<cword>"))<CR>

vnoremap Tja y:call Lookup("trans", ":ja -w 60 -b", "<C-R>"")<CR>
vnoremap Ten y:call Lookup("trans", ":en -w 60 -b", "<C-R>"")<CR>
vnoremap Tzh y:call Lookup("trans", ":zh -w 60 -b", "<C-R>"")<CR>

