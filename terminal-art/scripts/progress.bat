@echo off
REM Animated progress bar with percentage and ETA
REM Usage: progress.bat <total_seconds> [label]
setlocal EnableDelayedExpansion

set "TOTAL=%~1"
if "%TOTAL%"=="" set "TOTAL=10"

set "LABEL=%~2"
if "%LABEL%"=="" set "LABEL=Progress"

set "WIDTH=40"
set /a "STEP=WIDTH / TOTAL"

for /l %%i in (0,1,%TOTAL%) do (
    set /a "PCT=%%i * 100 / TOTAL"
    set /a "FILLED=%%i * WIDTH / TOTAL"
    set /a "EMPTY=WIDTH - FILLED"
    set /a "REMAINING=TOTAL - %%i"

    set "BAR="
    for /l %%b in (1,1,!FILLED!) do set "BAR=!BAR!#"
    for /l %%b in (1,1,!EMPTY!) do set "BAR=!BAR!-"

    <nul set /p "=  %LABEL%: [!BAR!] !PCT!%%  ETA: !REMAINING!s     ^M"
    ping -n 2 127.0.0.1 >nul
)

echo.
echo   %LABEL%: Done!
endlocal
