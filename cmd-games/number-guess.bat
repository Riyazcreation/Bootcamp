@echo off
setlocal EnableDelayedExpansion
title Number Guesser

set "DIFF=%~1"
if /i "!DIFF!"=="easy"   set /a "MAX=50"  & set "TRIES=8"
if /i "!DIFF!"=="hard"   set /a "MAX=1000" & set "TRIES=12"
if not defined MAX       set /a "MAX=100"  & set "TRIES=10"

set /a "SECRET=!RANDOM! %% MAX + 1"
set /a "LEFT=TRIES"

cls
echo ============================================================
echo   Number Guesser  ^|  Range: 1-%MAX%  ^|  Guesses: %TRIES%
echo ============================================================
echo.

:guess_loop
if !LEFT! LEQ 0 (
    echo   Out of guesses! The number was !SECRET!.
    goto :end
)

set /p "GUESS=  Your guess (%LEFT% left): "

if not defined GUESS goto :guess_loop
set /a "GUESS+=0" 2>nul

if !GUESS! LSS 1 (echo   Enter a number between 1 and %MAX%) & goto :guess_loop
if !GUESS! GTR %MAX% (echo   Enter a number between 1 and %MAX%) & goto :guess_loop

if !GUESS! EQU !SECRET! (
    echo.
    echo   Correct! You got it in !LEFT! guesses remaining!
    goto :end
)

if !GUESS! LSS !SECRET! (
    echo   Too low!
) else (
    echo   Too high!
)

set /a "LEFT-=1"
goto :guess_loop

:end
echo.
set /p "REPLAY=  Play again? (Y/N): "
if /i "!REPLAY!"=="Y" (
    endlocal
    goto :eof
    call "%~f0" %1
) else (
    echo   Thanks for playing!
)
endlocal
