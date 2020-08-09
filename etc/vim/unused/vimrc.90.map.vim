"------------------------------------------------------
" map: unused
"------------------------------------------------------
if 0
  " global
  nnoremap <silent> <Space>f :Gtags -f %<CR>
  nnoremap <silent> <Space>j :GtagsCursor<CR>
  nnoremap <silent> <Space>d :<C-u>exe('Gtags '.expand('<cword>'))<CR>
  nnoremap <silent> <Space>r :<C-u>exe('Gtags -r '.expand('<cword>'))<CR>

  " tagbar
  nnoremap <F?> :TagbarToggle<CR>
endif

