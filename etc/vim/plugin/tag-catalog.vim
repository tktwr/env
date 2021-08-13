"======================================================
" TagCatalog
"======================================================
if exists("g:loaded_tag_catalog")
  finish
endif
let g:loaded_tag_catalog = 1

let s:tag_catalog_winname = '\[tag-catalog\]'

"------------------------------------------------------
" private func
"------------------------------------------------------
func TgClogPut0(text)
  silent 0put =a:text
endfunc

func TgClogPut(text)
  silent put =a:text
endfunc

func TgClogRemoveCR(str)
  return substitute(a:str, '\r', '', 'g')
endfunc

func TgClogMySystem(str)
  return TgClogRemoveCR(system(a:str))
endfunc

"------------------------------------------------------
" window
"------------------------------------------------------
func TgClogMakeWindow(title)
  exec "edit" a:title
  setlocal filetype=tag-catalog
  setlocal syntax=txt
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal buflisted
  setlocal noswapfile
  setlocal nowrap
  "setlocal readonly
endfunc

func TgClogUpdate(file, type)
  silent %d _
  let width = winwidth(0)
  let cmd = "print-tags.py ".a:file." ".width." ".a:type
  let text = TgClogMySystem(cmd)
  call TgClogPut0(text)
  normal 1G
endfunc

func TagCatalog(file, type)
  let title = s:tag_catalog_winname." ".a:file
  call TgClogMakeWindow(title)
  call TgClogUpdate(a:file, a:type)
endfunc

"command -nargs=2 -complete=file TagCatalog call TagCatalog(<f-args>)

"------------------------------------------------------
" autocmd
"------------------------------------------------------
func TgClogTjump(tag_name)
  exec "tjump ".a:tag_name
endfunc

func s:init_tag_catalog()
  nnoremap <buffer> <silent> <CR> :call TgClogTjump(expand("<cWORD>"))<CR>
  nnoremap <buffer> <silent> l    W
  nnoremap <buffer> <silent> h    B
endfunc

augroup ag_tag_catalog
  autocmd! *
  autocmd FileType tag-catalog call s:init_tag_catalog()
augroup END

