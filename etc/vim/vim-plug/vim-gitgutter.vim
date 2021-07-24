if &term =~ "xterm"
  Plug 'airblade/vim-gitgutter'
  let g:gitgutter_map_keys = 0
  let g:gitgutter_override_sign_column_highlight = 0
  highlight SignColumn ctermbg=0
endif
