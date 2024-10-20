"------------------------------------------------------
" fern
"------------------------------------------------------
"Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern.vim', {'commit': 'a675dff495a0a0fd15663ebbae585c19825a64c5'}  " work with vim prior to 8.2.5136
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/glyph-palette.vim'

if $MY_PROMPT_TYPE >= 4
  Plug 'lambdalisue/fern-git-status.vim'
endif

let g:fern#drawer_width = g:my_left_winwidth
let g:fern#disable_default_mappings = 1
let g:fern#renderer = 'nerdfont'
"let g:fern#renderer#default#leading = "  "
let g:fern#renderer#nerdfont#padding = " "
"let g:fern_disable_startup_warnings = 1
