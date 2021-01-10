IfWinExist ahk_exe firefox.exe
{
  WinActivate
  send,#{Left}
}
IfWinExist ahk_exe mintty.exe
{
  WinActivate
  send,#{Right}
  send,{F8}
}
