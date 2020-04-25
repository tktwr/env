"
" for html
"
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setl tabstop=2
setl shiftwidth=2

nmap <buffer> com  I<!--<ESC>A--><ESC>
nmap <buffer> moc  $xxx^xxxx

" abbrebiations
iabclear
iabbr Y<      &lt;
iabbr Y>      &gt;
iabbr Y"      &quot;
iabbr Y&      &amp;
iabbr Yvbar   &brvbar;
iabbr Yspace  &nbsp;
iabbr LI      <li><a href=""></a></li>

