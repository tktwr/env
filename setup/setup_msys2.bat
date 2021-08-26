REM make symbolic links for msys2

cd C:\msys64\home\%USERNAME%

mklink /d WinHome %USERPROFILE%

mklink /d Desktop WinHome\Desktop
mklink /d Downloads WinHome\Downloads
mklink /d MyConfig WinHome\MyConfig
mklink /d MyShare WinHome\MyShare

REM mklink /d Dropbox WinHome\Dropbox
REM mklink /d GoogleDrive WinHome\GoogleDrive
REM mklink /d .vim MyConfig\tktwr.github\env\etc\vim

pause
