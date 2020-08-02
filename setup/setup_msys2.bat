REM make symbolic links for msys2

mklink /d WinHome %USERPROFILE%

mklink /d Desktop WinHome\Desktop
mklink /d Downloads WinHome\Downloads
mklink /d Dropbox WinHome\Dropbox
mklink /d GoogleDrive "WinHome\Google\ ドライブ"
mklink /d MyConfig WinHome\MyConfig

REM mklink /d .vim MyConfig\tktwr.github\env\etc\vim

