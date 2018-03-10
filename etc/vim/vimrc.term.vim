" term

if ($TERM == "xterm")
  " mouse support
  set mouse=a
  set ttymouse=xterm2
endif

" syntax highlighting for a colored terminal
if (&t_Co > 1)
  syntax enable
  hi Folded     ctermfg=5 ctermbg=0
  hi FoldColumn ctermfg=5 ctermbg=0

  hi DiffAdd    ctermfg=7
  hi DiffChange ctermfg=7
  hi DiffDelete ctermfg=7
  hi DiffText   ctermfg=7

  hi TabLine      ctermfg=3 ctermbg=0
  hi TabLineFill  ctermfg=0 ctermbg=3
  hi TabLineSel   ctermfg=0 ctermbg=3
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

