" term

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

  "hi StatusLine   ctermfg=7,reverse
  "hi StatusLineNC ctermfg=7,reverse

  hi VertSplit    ctermfg=7 ctermbg=7
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

