"======================================================
" term
"======================================================
set termguicolors
set t_Co=256
set background=dark

if &term =~ "xterm"
  " mouse support
  set mouse=a
  set ttymouse=xterm2
endif

"======================================================
" highlight
"======================================================
hi MyRed           ctermfg =167 guifg=#fb4934
hi MyRedRevBold    ctermfg =167 guifg=#fb4934 cterm=reverse,bold gui=reverse,bold
hi MyGreen         ctermfg =142 guifg=#b8bb26
hi MyGreenRevBold  ctermfg =142 guifg=#b8bb26 cterm=reverse,bold gui=reverse,bold
hi MyYellow        ctermfg =214 guifg=#fabd2f
hi MyYellowRevBold ctermfg =214 guifg=#fabd2f cterm=reverse,bold gui=reverse,bold
hi MyBlue          ctermfg =109 guifg=#83a598
hi MyBlueRevBold   ctermfg =109 guifg=#83a598 cterm=reverse,bold gui=reverse,bold
hi MyPurple        ctermfg =175 guifg=#d3869b
hi MyPurpleRevBold ctermfg =175 guifg=#d3869b cterm=reverse,bold gui=reverse,bold
hi MyAqua          ctermfg =108 guifg=#8ec07c
hi MyAquaRevBold   ctermfg =108 guifg=#8ec07c cterm=reverse,bold gui=reverse,bold
hi MyOrange        ctermfg =208 guifg=#fe8019
hi MyOrangeRevBold ctermfg =208 guifg=#fe8019 cterm=reverse,bold gui=reverse,bold
hi MyRedSign       ctermfg =167 ctermbg=237 guifg=#fb4934 guibg=#3c3836
hi MyGreenSign     ctermfg =142 ctermbg=237 guifg=#b8bb26 guibg=#3c3836
hi MyYellowSign    ctermfg =214 ctermbg=237 guifg=#fabd2f guibg=#3c3836
hi MyBlueSign      ctermfg =109 ctermbg=237 guifg=#83a598 guibg=#3c3836
hi MyPurpleSign    ctermfg =175 ctermbg=237 guifg=#d3869b guibg=#3c3836
hi MyAquaSign      ctermfg =108 ctermbg=237 guifg=#8ec07c guibg=#3c3836
hi MyOrangeSign    ctermfg =208 ctermbg=237 guifg=#fe8019 guibg=#3c3836

hi! link Folded     MyYellowSign
hi! link FoldColumn MyYellowSign
hi! link WildMenu   MyYellowRevBold

"======================================================
" statusline
"======================================================
"hi User1 ctermfg=0 ctermbg=2 guifg=#464646 guibg=#90A959 cterm=bold gui=bold
"hi User2 ctermfg=0 ctermbg=2 guifg=#464646 guibg=#90A959 cterm=bold gui=bold
hi! link User1   MyAquaRevBold
hi! link User2   MyAquaRevBold

set laststatus=2
set statusline=%1*%<%f%0*
set statusline+=\ %h%m%r%w%{'['.(&fenc!=''?&fenc:&enc).','.&ff.']'}
set statusline+=%=%l/%L,%c%V%4p%%
set statusline+=\ %2*%{fugitive#statusline()}%0*

