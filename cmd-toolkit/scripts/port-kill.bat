@echo off
setlocal EnableDelayedExpansion
title Port Kill

if "%1"=="" (
    echo Usage: port-kill.bat ^<port^>
    echo Example: port-kill.bat 3000
    exit /b 1
)

set "PORT=%1"
echo Looking for processes using port %PORT%...
echo.

REM Find PID using the port
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":%PORT% " ^| findstr "LISTENING"') do (
    set "PID=%%a"
)

if not defined PID (
    echo No process found listening on port %PORT%.
    exit /b 0
)

REM Get process name
for /f "tokens=1" %%a in ('tasklist /fi "PID eq !PID!" /fo csv /nh') do (
    set "PROCNAME=%%~a"
)

echo Found: !PROCNAME! (PID !PID!) on port %PORT%
set /p "CONFIRM=Kill this process? (Y/N): "

if /i "!CONFIRM!"=="Y" (
    taskkill /PID !PID! /F
    echo Process !PID! killed.
) else (
    echo Cancelled.
)

endlocal
