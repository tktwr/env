"======================================================
" Custom Popup Menu
"======================================================
if exists("g:loaded_cpmenu")
  "finish
endif
let g:loaded_cpmenu = 1

let s:cpm_files = g:cpm_files
let s:cpm_titles = g:cpm_titles

" menu_entry: cmd/dir/url
let s:cpm_cmd_dict = {}

" title: menu_list
let s:cpm_menu_all = {}

let s:separator = "------------------------------"

"------------------------------------------------------
" util
"------------------------------------------------------
func s:CpmFillItem(str, separator)
  let n = len(a:str)
  let o = a:str.a:separator[n:]
  return o
endfunc

func s:CpmFindByKey(list_of_str, pattern)
  let idx = 0
  for s in a:list_of_str
    if (match(s, a:pattern) == 0)
      return idx
    endif
    let idx = idx + 1
  endfor
  return -1
endfunc

"------------------------------------------------------
" load
"------------------------------------------------------
func s:CpmRegisterSeparator(list, dict, title)
  let key = s:CpmFillItem(a:title, s:separator)
  let val = ":echo"

  let a:dict[key] = val
  call add(a:list, key)
endfunc

func s:CpmRegister(list, dict, line)
  let line = a:line
  let key = BmkGetItem(line, 1)
  let val = BmkGetItem(line, 2)

  let key = " ".key." "

  let a:dict[key] = val
  call add(a:list, key)
endfunc

func s:CpmLoad(cmd_file)
  let cmd_file = expand(a:cmd_file)
  if !filereadable(cmd_file)
    return
  endif

  let lines = readfile(cmd_file)
  for line in lines
    if (match(line, '^\[.\+\]') == 0)
      " title
      let title = BmkGetTitle(line)

      let menu = []
      let s:cpm_menu_all[title] = menu
      call s:CpmRegisterSeparator(menu, s:cpm_cmd_dict, "[".title."] ")
    elseif (match(line, '^\s*---') == 0)
      " separator
      call s:CpmRegisterSeparator(menu, s:cpm_cmd_dict, "   ")
    elseif (match(line, '^\s*[-+] ') == 0)
      " item
      call s:CpmRegister(menu, s:cpm_cmd_dict, line)
    endif
  endfor
endfunc

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func s:CpmGetNumTitles()
  if &buftype == 'terminal'
    let size = len(s:cpm_titles['terminal'])
  elseif &filetype == 'fern'
    let size = len(s:cpm_titles['fern'])
  else
    let size = len(s:cpm_titles['buffer'])
  endif
  return size
endfunc

func s:CpmNextNr()
  let n = s:CpmGetNumTitles()
  return (w:cpm_menu_nr + 1) % n
endfunc

func s:CpmPrevNr()
  let n = s:CpmGetNumTitles()
  return w:cpm_menu_nr == 0 ? n - 1 : w:cpm_menu_nr - 1
endfunc

func s:CpmGetMenu(nr)
  if &buftype == 'terminal'
    let title = s:cpm_titles['terminal'][a:nr]
  elseif &filetype == 'fern'
    let title = s:cpm_titles['fern'][a:nr]
  else
    let title = s:cpm_titles['buffer'][a:nr]
  endif
  return s:cpm_menu_all[title]
endfunc

func s:CpmFixPos(id)
  call popup_move(a:id, #{
  \ pos: 'botleft',
  \ line: 'cursor-1',
  \ col: 'cursor',
  \ })
endfunc

func CpmFilter(id, key)
  if a:key == "\<Space>" || a:key == "\<C-Space>"
    call popup_close(a:id, 0)
    return 1
  elseif a:key == '0'
    call s:CpmFixPos(a:id)
    return 1
  elseif a:key == 'l'
    call popup_close(a:id, 0)
    let nr = s:CpmNextNr()
    let id = s:CpmOpen(nr)
    call s:CpmFixPos(id)
    return 1
  elseif a:key == 'h'
    call popup_close(a:id, 0)
    let nr = s:CpmPrevNr()
    let id = s:CpmOpen(nr)
    call s:CpmFixPos(id)
    return 1
  else
    let idx = s:CpmFindByKey(w:cpm_menu, '^ '.a:key.' ')
    if (idx != -1)
      let idx = idx + 1
      call popup_close(a:id, idx)
      return 1
    endif
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func CpmHandler(id, result)
  if a:result == 0
  elseif a:result > 0
    let idx = a:result - 1

    " key in menu
    let cmd = s:cpm_cmd_dict[w:cpm_menu[idx]]
    let cmd = expand(cmd)

    call BmkEdit(cmd, 0)
  endif
endfunc

func s:CpmOpen(menu_nr)
  let w:cpm_menu_nr = a:menu_nr
  let w:cpm_menu = s:CpmGetMenu(w:cpm_menu_nr)
  let winid = popup_menu(w:cpm_menu, #{
    \ filter: 'CpmFilter',
    \ callback: 'CpmHandler',
    \ border: [0,0,0,0],
    \ padding: [0,0,0,0],
    \ pos: 'botleft',
    \ line: 'cursor-1',
    \ col: 'cursor',
    \ moved: 'WORD',
    \ })
  return winid
endfunc

"------------------------------------------------------
" init
"------------------------------------------------------
func s:CpmReload()
  let s:cpm_cmd_dict = {}
  let s:cpm_menu_all = {}
  for file in s:cpm_files
    call s:CpmLoad(file)
  endfor
endfunc

func s:CpmInit()
  call s:CpmReload()
endfunc

call s:CpmInit()

"------------------------------------------------------
" public command
"------------------------------------------------------
command          CpmReload    call s:CpmReload()
command -nargs=1 CpmOpen      call s:CpmOpen(<f-args>)

