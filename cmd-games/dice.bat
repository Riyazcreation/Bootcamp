@echo off
setlocal EnableDelayedExpansion
title Dice Roller

if "%~1"=="" (
    echo Usage: dice.bat ^<NdS^> [advantage^|disadvantage]
    echo.
    echo   Examples:
    echo     dice.bat 2d6
    echo     dice.bat 1d20 advantage
    echo     dice.bat 4d4
    exit /b 1
)

set "NOTATION=%~1"
set "MOD=%~2"

REM Parse NdS
for /f "tokens=1,2 delims=d" %%a in ("!NOTATION!") do (
    set /a "NUM=%%a"
    set /a "SIDES=%%b"
)

if !NUM! LEQ 0 set /a "NUM=1"
if !SIDES! LEQ 1 (
    echo Invalid die sides: !SIDES!
    exit /b 1
)

echo.
echo   Rolling !NUM!d!SIDES!...
echo.

set /a "TOTAL=0"
set "ROLLS="

for /l %%i in (1,1,!NUM!) do (
    set /a "R=!RANDOM! %% SIDES + 1"
    set "ROLLS=!ROLLS! !R!"
    set /a "TOTAL+=R"
)

if /i "!MOD!"=="advantage" (
    set /a "R2=!RANDOM! %% SIDES + 1"
    if !R2! GTR !TOTAL! (
        echo   First roll: !TOTAL!
        echo   Second roll: !R2! ^<-- higher, taking this
        set /a "TOTAL=R2"
    ) else (
        echo   First roll: !TOTAL! ^<-- higher, taking this
        echo   Second roll: !R2!
    )
) else if /i "!MOD!"=="disadvantage" (
    set /a "R2=!RANDOM! %% SIDES + 1"
    if !R2! LSS !TOTAL! (
        echo   First roll: !TOTAL!
        echo   Second roll: !R2! ^<-- lower, taking this
        set /a "TOTAL=R2"
    ) else (
        echo   First roll: !TOTAL! ^<-- lower, taking this
        echo   Second roll: !R2!
    )
) else (
    echo   Rolls:!ROLLS!
)

echo.
echo   Total: !TOTAL!
echo.
endlocal
