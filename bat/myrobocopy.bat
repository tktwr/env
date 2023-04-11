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
rem  /NP ... no progress

robocopy %* /R:3 /MIR /SL /XD ".git" ".svn" "build.*" "__pycache__" /XJD /XJF /TEE /NP /LOG+:myrobocopy.log

pause

