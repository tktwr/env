rem print more than 200MB
WMIC PATH Win32_PerfFormattedData_PerfProc_Process WHERE "WorkingSet > 200000000 AND Name != '_Total'" GET /FORMAT:LIST

rem total
rem WMIC PATH Win32_PerfFormattedData_PerfProc_Process WHERE "Name = '_Total'" GET /FORMAT:LIST
