@echo off

rem myrobocopy.bat src_dir dst_dir opt
rem
rem src_dir, dst_dir:
rem   C:/dir
rem   C:\dir
rem   \\pcname\dir
rem
rem opt:
rem  /L ... no run

robocopy %* /R:3 /MIR /SL /XD ".git" ".svn" "build.*" "plugged" "coc_data" "__pycache__" /XJD /XJF /TEE /NP /LOG:mymirror.log

pause

