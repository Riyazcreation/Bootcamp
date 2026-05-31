@echo off
REM Reusable animated spinner for CMD scripts
REM Usage: call spinner.bat <message> <duration_seconds>
REM        OR: start /b spinner.bat working... 0  (0 = run until Ctrl+C)
setlocal EnableDelayedExpansion

set "MSG=%~1"
if "%MSG%"=="" set "MSG=Working..."

set "SECS=%~2"
if "%SECS%"=="" set "SECS=5"

set "FRAMES=| / - \"
set /a "TICKS=SECS * 8"
if %SECS%==0 set /a "TICKS=99999"

set /a "F=0"
for /l %%i in (1,1,%TICKS%) do (
    set /a "IDX=F %% 4"
    for /f "tokens=!IDX!" %%c in ("%FRAMES%") do (
        <nul set /p "=  %%c  %MSG%"
        ping -n 1 -w 125 127.0.0.1 >nul
        <nul set /p "=                              "
        <nul set /p "=^M"
    )
    set /a "F+=1"
)
echo.
endlocal
