REM make symbolic links for msys2

cd C:\msys64\home\%USERNAME%

mklink /d WinHome %USERPROFILE%

mklink /d Desktop WinHome\Desktop
mklink /d Downloads WinHome\Downloads
mklink /d MyRoaming WinHome\MyRoaming
mklink /d MyConfig WinHome\MyConfig
mklink /d MyShare WinHome\MyShare

REM for coc-settings.json
mklink /d .vim WinHome\.vim

REM mklink /d Dropbox WinHome\Dropbox
REM mklink /d GoogleDrive WinHome\GoogleDrive

pause
