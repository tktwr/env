REM make symbolic links for msys2

mklink /d WinHome %USERPROFILE%

mklink /d Desktop WinHome\Desktop
mklink /d Downloads WinHome\Downloads
mklink /d Dropbox WinHome\Dropbox
mklink /d GoogleDrive "WinHome\Google\ ドライブ"

REM mklink /d .vim WinHome\tktwr.github\env\etc\vim

