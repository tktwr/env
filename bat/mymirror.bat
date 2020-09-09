@echo off

rem \\pcname\dir
rem C:\dir

set SRC=%1
set DST=%2

rem robocopy %SRC% %DST% /R:3 /MIR /SL /XJD /XJF /TEE /NP /LOG:mymirror.log /L
robocopy %SRC% %DST% /R:3 /MIR /SL /XJD /XJF /TEE /NP /LOG:mymirror.log

pause

