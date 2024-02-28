"======================================================
" highlight
"======================================================
let my_colors = [
      \ {'name': 'MyRed'         , 'ctermfg': 167 , 'guifg': '#fb4934'} ,
      \ {'name': 'MyOrange'      , 'ctermfg': 208 , 'guifg': '#fe8019'} ,
      \ {'name': 'MyYellow'      , 'ctermfg': 214 , 'guifg': '#fabd2f'} ,
      \ {'name': 'MyGreen'       , 'ctermfg': 142 , 'guifg': '#b8bb26'} ,
      \ {'name': 'MyAqua'        , 'ctermfg': 108 , 'guifg': '#8ec07c'} ,
      \ {'name': 'MyBlue'        , 'ctermfg': 109 , 'guifg': '#707fd9'} ,
      \ {'name': 'MyPurple'      , 'ctermfg': 175 , 'guifg': '#d3869b'} ,
      \ {'name': 'MyDark1Red'    , 'ctermfg': 124 , 'guifg': '#cc241d'} ,
      \ {'name': 'MyDark1Orange' , 'ctermfg': 166 , 'guifg': '#d65d0e'} ,
      \ {'name': 'MyDark1Yellow' , 'ctermfg': 172 , 'guifg': '#d79921'} ,
      \ {'name': 'MyDark1Green'  , 'ctermfg': 106 , 'guifg': '#98971a'} ,
      \ {'name': 'MyDark1Aqua'   , 'ctermfg': 72  , 'guifg': '#689d6a'} ,
      \ {'name': 'MyDark1Blue'   , 'ctermfg': 66  , 'guifg': '#458588'} ,
      \ {'name': 'MyDark1Purple' , 'ctermfg': 132 , 'guifg': '#b16286'} ,
      \ {'name': 'MyDark2Red'    , 'ctermfg': 88  , 'guifg': '#9d0006'} ,
      \ {'name': 'MyDark2Orange' , 'ctermfg': 130 , 'guifg': '#af3a03'} ,
      \ {'name': 'MyDark2Yellow' , 'ctermfg': 136 , 'guifg': '#b57614'} ,
      \ {'name': 'MyDark2Green'  , 'ctermfg': 100 , 'guifg': '#79740e'} ,
      \ {'name': 'MyDark2Aqua'   , 'ctermfg': 66  , 'guifg': '#427b58'} ,
      \ {'name': 'MyDark2Blue'   , 'ctermfg': 24  , 'guifg': '#076678'} ,
      \ {'name': 'MyDark2Purple' , 'ctermfg': 96  , 'guifg': '#8f3f71'} ,
      \ ]

for co in my_colors
  exec printf('hi %s         ctermfg=%d guifg=%s', co['name'], co['ctermfg'], co['guifg'])
  exec printf('hi %sSign     ctermfg=%d guifg=%s ctermbg=237 guibg=#3c3836', co['name'], co['ctermfg'], co['guifg'])
  exec printf('hi %sRevBold  ctermfg=%d guifg=%s cterm=reverse,bold gui=reverse,bold', co['name'], co['ctermfg'], co['guifg'])
endfor

hi MyFg0           ctermfg=229 guifg=#fbf1c7
hi MyFg1           ctermfg=223 guifg=#ebdbb2
hi MyFg2           ctermfg=250 guifg=#d5c4a1
hi MyFg3           ctermfg=248 guifg=#bdae93
hi MyFg4           ctermfg=246 guifg=#a89984

hi MyGray          ctermfg=245 guifg=#928374
hi MyDarkGray      ctermfg=239 guifg=#504945

hi MyBg0           ctermbg=236 guibg=#32302f
hi MyBg1           ctermbg=237 guibg=#3c3836
hi MyBg2           ctermbg=239 guibg=#504945
hi MyBg3           ctermbg=241 guibg=#665c54
hi MyBg4           ctermbg=243 guibg=#7c6f64

hi MyBg1a          ctermbg=237 guibg=#3c3c36
hi MyBgTerm        ctermbg=235 guibg=#252525

hi MyNormal        ctermfg=223 guifg=#ebdbb2 ctermbg=236 guibg=#32302f
hi MyStatusLine    ctermfg=223 guifg=#ebdbb2 ctermbg=239 guibg=#504945
hi MyStatusLineNC  ctermfg=246 guifg=#a89984 ctermbg=237 guibg=#3c3836

"------------------------------------------------------
" highlight link
"------------------------------------------------------
hi! link StatusLine         MyStatusLine
hi! link StatusLineNC       MyStatusLineNC
hi! link StatusLineTerm     MyStatusLine
hi! link StatusLineTermNC   MyStatusLineNC

hi! link TabLineSel         MyGreenRevBold
hi! link TabLine            MyDark2GreenRevBold
hi! link TabLineFill        MyStatusLineNC

hi! link Folded             MyYellowSign
hi! link FoldColumn         MyYellowSign

hi! link Terminal           MyBgTerm

hi! link Pmenu              MyNormal
hi! link PmenuSel           MyBg3

hi! link CocErrorHighlight  MyRedRevBold
hi! link CocFloating        MyNormal

hi! link WildMenu           MyYellowRevBold
hi! link WhichKeyFloating   MyYellowSign
hi! link IndentGuidesOdd    MyBg0
hi! link IndentGuidesEven   MyBg1a

hi! link User1              MyRedRevBold
hi! link User2              MyGreenRevBold
hi! link User3              MyYellowRevBold
hi! link User4              MyBlueRevBold
hi! link User5              MyPurpleRevBold
hi! link User6              MyAquaRevBold
hi! link User7              MyOrangeRevBold

