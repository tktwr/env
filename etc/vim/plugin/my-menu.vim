"======================================================
" MyMenu
"======================================================
if exists("g:loaded_my_menu")
  finish
endif
let g:loaded_my_menu = 1

let s:cmd_files = g:cmd_files
let s:cmd_dict = {}
let s:my_menu_edit = []
let s:my_menu_term = []
let s:separator = "------------------------------"

"------------------------------------------------------
" load
"------------------------------------------------------
func Fill(str, separator)
  let n = len(a:str)
  let o = a:str.a:separator[n:]
  return o
endfunc

func s:MyMenuRegisterSeparator(list, dict, title)
  let key = Fill(a:title, s:separator)
  let val = ":echo"

  let a:dict[key] = val
  call add(a:list, key)
endfunc

func s:MyMenuRegister(list, dict, line)
  let line = a:line
  let key = BmkGetItem(line, 1)
  let val = BmkGetItem(line, 2)

  let key = BmkRemoveEndSpaces(key)
  let key = " ".key." "

  let a:dict[key] = val
  call add(a:list, key)
endfunc

func s:MyMenuLoad(cmd_file)
  let cmd_file = expand(a:cmd_file)
  if !filereadable(cmd_file)
    return
  endif

  let lines = readfile(cmd_file)
  for line in lines
    if (match(line, '^\[.\+\]') == 0)
      " title
      let title = BmkGetTitle(line)
      if (match(title, 'terminal') == 0)
        let menu = s:my_menu_term
      else
        let menu = s:my_menu_edit
      endif
      call add(menu, [])
      call s:MyMenuRegisterSeparator(menu[-1], s:cmd_dict, "[".title."] ")
    elseif (match(line, '^\s*---') == 0)
      " separator
      call s:MyMenuRegisterSeparator(menu[-1], s:cmd_dict, "   ")
    elseif (match(line, '^\s*- ') == 0)
      " item
      call s:MyMenuRegister(menu[-1], s:cmd_dict, line)
    endif
  endfor
endfunc

"------------------------------------------------------
" popup menu
"------------------------------------------------------
func MyMenuNext()
  if &buftype == 'terminal'
    return (w:my_menu_nr + 1) % len(s:my_menu_term)
  else
    return (w:my_menu_nr + 1) % len(s:my_menu_edit)
  endif
endfunc

func MyMenuPrev()
  if &buftype == 'terminal'
    return w:my_menu_nr == 0 ? len(s:my_menu_term) - 1 : w:my_menu_nr - 1
  else
    return w:my_menu_nr == 0 ? len(s:my_menu_edit) - 1 : w:my_menu_nr - 1
  endif
endfunc

func MyMenuList(nr)
  if &buftype == 'terminal'
    return s:my_menu_term[a:nr]
  else
    return s:my_menu_edit[a:nr]
  endif
endfunc

func MyMenuExec(cmd)
  call BmkExecCommand(a:cmd, 0)
endfunc

func Find(menu, pattern)
  let idx = 0
  for s in a:menu
    if (match(s, a:pattern) == 0)
      return idx
    endif
    let idx = idx + 1
  endfor
  return -1
endfunc

func MyMenuFixPos(id)
  call popup_move(a:id, #{
  \ pos: 'botleft',
  \ line: 'cursor-1',
  \ col: 'cursor',
  \ })
endfunc

func MyMenuPopupMenuFilter(id, key)
  if a:key == "\<Space>" || a:key == "\<C-Space>"
    call popup_close(a:id, 0)
    return 1
  elseif a:key == '0'
    call MyMenuFixPos(a:id)
    return 1
  elseif a:key == 'l'
    call popup_close(a:id, 0)
    let nr = MyMenuNext()
    let id = MyMenuPopupMenu(nr)
    call MyMenuFixPos(id)
    return 1
  elseif a:key == 'h'
    call popup_close(a:id, 0)
    let nr = MyMenuPrev()
    let id = MyMenuPopupMenu(nr)
    call MyMenuFixPos(id)
    return 1
  else
    let idx = Find(w:my_menu, '^ '.a:key.' ')
    if (idx != -1)
      let idx = idx + 1
      call popup_close(a:id, idx)
      return 1
    endif
  endif
  return popup_filter_menu(a:id, a:key)
endfunc

func MyMenuPopupMenuHandler(id, result)
  if a:result == 0
  elseif a:result > 0
    let idx = a:result - 1

    " key in menu
    let cmd = s:cmd_dict[w:my_menu[idx]]

    call MyMenuExec(cmd)
  endif
endfunc

func MyMenuPopupMenu(menu_nr)
  let w:my_menu_nr = a:menu_nr
  let w:my_menu = MyMenuList(w:my_menu_nr)
  let winid = popup_menu(w:my_menu, #{
    \ filter: 'MyMenuPopupMenuFilter',
    \ callback: 'MyMenuPopupMenuHandler',
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
func s:MyMenuReload()
  let s:cmd_dict = {}
  let s:my_menu_edit = []
  let s:my_menu_term = []
  for file in s:cmd_files
    call s:MyMenuLoad(file)
  endfor
endfunc

func s:MyMenuInit()
  call s:MyMenuReload()
endfunc

call s:MyMenuInit()

"------------------------------------------------------
" public command
"------------------------------------------------------
command MyMenuReload  call s:MyMenuReload()

