@echo off

rem check_disk.bat E:\

robocopy %* NUL /E /R:0 /W:0

pause
