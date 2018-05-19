" term

set termguicolors
set t_Co=256
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if ($TERM == "xterm")
  " mouse support
  set mouse=a
  set ttymouse=xterm2
endif

" syntax highlighting for a colored terminal
if (&t_Co > 1)
  syntax enable
  set background=dark

  hi Folded     ctermfg=5 ctermbg=0
  hi FoldColumn ctermfg=5 ctermbg=0

  hi DiffAdd    ctermfg=0 ctermbg=6
  hi DiffDelete ctermfg=6 ctermbg=0
  hi DiffChange ctermfg=7 ctermbg=0
  hi DiffText   ctermfg=7 ctermbg=1

  hi TabLine      ctermfg=3 ctermbg=0
  hi TabLineFill  ctermfg=0 ctermbg=3
  hi TabLineSel   ctermfg=0 ctermbg=3

  hi StatusLine   ctermfg=3 ctermbg=0 cterm=reverse,bold
  hi StatusLineNC ctermfg=3 ctermbg=0
  hi VertSplit    ctermfg=3 ctermbg=3
endif

" paste
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

