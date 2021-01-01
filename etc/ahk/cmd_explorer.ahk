IfWinExist ahk_exe explorer.exe
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
