"------------------------------------------------------
" fern
"------------------------------------------------------
if v:true
  " work with vim prior to 8.2.5136 (Ubuntu 22.04)
  Plug 'lambdalisue/fern.vim'                   , {'commit': 'a675dff'}
  Plug 'lambdalisue/nerdfont.vim'               , {'commit': '4dec28b'}
  Plug 'lambdalisue/fern-renderer-nerdfont.vim' , {'commit': '84fae1b'}
  Plug 'lambdalisue/glyph-palette.vim'          , {'commit': 'acc67da'}
  if $MY_PROMPT_TYPE >= 4
    Plug 'lambdalisue/fern-git-status.vim', {'commit': '1513363'}
  endif
else
  Plug 'lambdalisue/vim-fern'
  Plug 'lambdalisue/vim-nerdfont'
  Plug 'lambdalisue/vim-fern-renderer-nerdfont'
  Plug 'lambdalisue/vim-glyph-palette'
  if $MY_PROMPT_TYPE >= 4
    Plug 'lambdalisue/vim-fern-git-status'
  endif
endif

let g:fern#drawer_width = g:my_left_winwidth
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'
"let g:fern#renderer#default#leading = "  "
let g:fern#renderer#nerdfont#padding = " "
"let g:fern_disable_startup_warnings = 1
