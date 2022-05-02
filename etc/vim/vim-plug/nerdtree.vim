"------------------------------------------------------
" nerdtree
"------------------------------------------------------
Plug 'scrooloose/nerdtree'

let g:NERDTreeWinSize = g:my_left_winwidth
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeShowBookmarks = 0
let g:NERDTreeChDirMode = 2
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 0
let g:NERDTreeIgnore = ['NTUSER\.', 'ntuser\.', '\.lnk$', '\.url', 'desktop\.ini']

"------------------------------------------------------
" nerdtree-git-plugin
"------------------------------------------------------
if v:false
  Plug 'Xuyuanp/nerdtree-git-plugin'
  let g:NERDTreeGitStatusEnable=1
  let g:NERDTreeGitStatusShowIgnored=0
  let g:NERDTreeGitStatusIgnoreSubmodules=1
  let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  : 'M',
    \ 'Staged'    : 'S',
    \ 'Untracked' : 'U',
    \ 'Renamed'   : 'R',
    \ 'Unmerged'  : 'm',
    \ 'Deleted'   : 'D',
    \ 'Dirty'     : '!',
    \ 'Clean'     : 'C',
    \ 'Ignored'   : 'I',
    \ 'Unknown'   : 'u'
    \ }
endif

