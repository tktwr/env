"------------------------------------------------------
" fern
"------------------------------------------------------
Plug 'lambdalisue/fern.vim'
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

func s:my_fern_settings()
  nmap <buffer> <C-X>  :CpmOpen fern<CR>
  nmap <buffer> <C-Y>  :CpmOpen fzy<CR>
endfunc

augroup ag_fern
  autocmd!
  autocmd FileType fern          call s:my_fern_settings()
augroup END

