REM make symbolic links for msys2

mklink /d WinHome %USERPROFILE%

mklink /d Desktop WinHome\Desktop
mklink /d Downloads WinHome\Downloads
mklink /d Dropbox WinHome\Dropbox
mklink /d GoogleDrive "WinHome\Google\ ドライブ"

mklink /d env.github WinHome\env.github
mklink /d env.local WinHome\env.local

mklink /d .vim env.github\etc\vim

