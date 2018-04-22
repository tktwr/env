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
  let w:help = !w:help
  if (w:help)
    call s:PrintHelp()
  else
    call Lookup(w:prg, w:opt, w:word)
  endif
endfunc

"--------------------------------------------------------------------------
" s:DefineCommands ()
" define commands used in the [Lookup] window
"--------------------------------------------------------------------------
func! s:DefineCommands ()
  nnoremap <buffer> <silent> 1 :call Lookup(w:prg, "-e=1", w:word)<CR>
  nnoremap <buffer> <silent> 2 :call Lookup(w:prg, "-e=2", w:word)<CR>
  nnoremap <buffer> <silent> 3 :call Lookup(w:prg, "-e=3", w:word)<CR>
  nnoremap <buffer> <silent> 4 :call Lookup(w:prg, "-e=4", w:word)<CR>
  nnoremap <buffer> <silent> 5 :call Lookup(w:prg, "-e=5", w:word)<CR>
  nnoremap <buffer> <silent> 6 :call Lookup(w:prg, "-e=6", w:word)<CR>
  nnoremap <buffer> <silent> 7 :call Lookup(w:prg, "-e=7", w:word)<CR>
  nnoremap <buffer> <silent> 8 :call Lookup(w:prg, "-e=8", w:word)<CR>
  nnoremap <buffer> <silent> 9 :call Lookup(w:prg, "-e=9", w:word)<CR>
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
func! Lookup (prg, opt, word)
  " check the window where the command is invoked
  if (!&previewwindow)
    let from_outside = 1
  else
    let from_outside = 0
  endif

  silent botright pedit \[Lookup\]
  wincmd P
  resize 12

  setlocal buftype=nofile
  setlocal bufhidden=delete
  setlocal noswapfile
  setlocal modifiable

  call s:DefineCommands()

  " store arguments to window-local variables
  let w:prg = a:prg
  let w:opt = a:opt
  let w:word = a:word
  let w:help = 0

  silent exec "!" a:prg a:opt a:word ">" s:tmpfile
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
command -nargs=1 Lookup call Lookup(&keywordprg, "", "<args>")
command -nargs=1 EJ call Lookup("ej", "", "<args>")
command -nargs=1 EE call Lookup("ee", "", "<args>")
command -nargs=1 GJ call Lookup("gj", "", "<args>")

