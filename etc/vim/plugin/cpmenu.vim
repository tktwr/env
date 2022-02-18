"======================================================
" Custom Popup Menu
"======================================================
if v:version < 802
  finish
endif

if exists("g:loaded_cpmenu")
  finish
endif
let g:loaded_cpmenu = 1

"------------------------------------------------------
" set global variables
"------------------------------------------------------
func s:SetGlobalVars()
  " set defaults
  let s:separator = "------------------------------"
  let s:cpm_key = "\<Space>"
  let s:cpm_term_key = "\<C-Space>"
  let s:cpm_files = []
  let s:cpm_titles = {
    \ 'buffer': [],
    \ 'terminal': [],
    \ }

  " set global variables
  if exists("g:cpm_key")
    let s:cpm_key = g:cpm_key
  endif
  if exists("g:cpm_term_key")
    let s:cpm_term_key = g:cpm_term_key
  endif
  if exists("g:cpm_files")
    let s:cpm_files = g:cpm_files
  endif
  if exists("g:cpm_titles")
    let s:cpm_titles = g:cpm_titles
  endif
endfunc

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
func s:CpmGetValidMenuName(name='')
  if a:name != ''
    let name = a:name
    let l = get(s:cpm_titles, name, [])
    if l != []
      return name
    endif
  endif

  if &buftype == 'terminal'
    let name = &buftype
    let l = get(s:cpm_titles, name, [])
    if l != []
      return name
    endif
  endif

  let name = 'ft:'.&filetype
  let l = get(s:cpm_titles, name, [])
  if l != []
    return name
  endif

  return 'buffer'
endfunc

func s:CpmGetMenu(name, nr)
  let title = s:cpm_titles[a:name][a:nr]
  return s:cpm_menu_all[title]
endfunc

func s:CpmGetNumTitles(name)
  return len(s:cpm_titles[a:name])
endfunc

func s:CpmNextNr()
  let n = s:CpmGetNumTitles(w:cpm_menu_name)
  return (w:cpm_menu_nr + 1) % n
endfunc

func s:CpmPrevNr()
  let n = s:CpmGetNumTitles(w:cpm_menu_name)
  return w:cpm_menu_nr == 0 ? n - 1 : w:cpm_menu_nr - 1
endfunc

func s:CpmFixPos(id)
  call popup_move(a:id, #{
  \ pos: 'botleft',
  \ line: 'cursor-1',
  \ col: 'cursor',
  \ })
endfunc

func CpmFilter(id, key)
  let w:edit_type = 0
  if a:key == s:cpm_key || a:key == s:cpm_term_key
    call popup_close(a:id, 0)
    return 1
  elseif a:key == '0'
    call s:CpmFixPos(a:id)
    return 1
  elseif a:key == 'l'
    call popup_close(a:id, 0)
    let nr = s:CpmNextNr()
    let id = s:CpmOpen(w:cpm_menu_name, nr)
    call s:CpmFixPos(id)
    return 1
  elseif a:key == 'h'
    call popup_close(a:id, 0)
    let nr = s:CpmPrevNr()
    let id = s:CpmOpen(w:cpm_menu_name, nr)
    call s:CpmFixPos(id)
    return 1
  elseif a:key == "\<C-CR>"
    let w:edit_type = 1
    return popup_filter_menu(a:id, "\<CR>")
  elseif a:key == "\<S-CR>"
    let w:edit_type = 2
    return popup_filter_menu(a:id, "\<CR>")
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

    if w:edit_type == 0
      call BmkEdit(cmd, 0)
    elseif w:edit_type == 1
      call BmkView(cmd, 0)
    elseif w:edit_type == 2
      call BmkOpen(cmd, 0)
    endif
  endif
endfunc

func s:CpmOpen(menu_name='', menu_nr=0)
  let w:cpm_menu_name = s:CpmGetValidMenuName(a:menu_name)
  let w:cpm_menu_nr = a:menu_nr
  let w:cpm_menu = s:CpmGetMenu(w:cpm_menu_name, w:cpm_menu_nr)
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
" reload
"------------------------------------------------------
func s:CpmReload()
  call s:SetGlobalVars()

  " menu_entry: cmd/dir/url
  let s:cpm_cmd_dict = {}

  " title: menu_list
  let s:cpm_menu_all = {}

  for file in s:cpm_files
    call s:CpmLoad(file)
  endfor

  " check wether titles exist in cpm_menu_all
  let loaded_titles = keys(s:cpm_menu_all)
  for menu_type in keys(s:cpm_titles)
    let titles = s:cpm_titles[menu_type]
    let valid_titles = []
    for i in titles
      let r = match(loaded_titles, i)
      if r != -1
        call add(valid_titles, i)
      endif
    endfor
    let s:cpm_titles[menu_type] = valid_titles
  endfor
endfunc

"------------------------------------------------------
" public command
"------------------------------------------------------
command          CpmReload    call s:CpmReload()
command -nargs=* CpmOpen      call s:CpmOpen(<f-args>)

"------------------------------------------------------
" init
"------------------------------------------------------
func s:Init()
  call s:CpmReload()
endfunc

call s:Init()

