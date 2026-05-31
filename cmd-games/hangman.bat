@echo off
setlocal EnableDelayedExpansion
title Hangman

REM Built-in word list
set "WORDS=KEYBOARD MONITOR TERMINAL WINDOWS COMMAND PROMPT SCRIPT NETWORK FOLDER DESKTOP BROWSER DOWNLOAD PIXEL CURSOR MEMORY"
set /a "WCOUNT=15"

REM Pick a random word
set /a "IDX=!RANDOM! %% WCOUNT + 1"
set /a "I=0"
for %%w in (%WORDS%) do (
    set /a "I+=1"
    if !I! EQU !IDX! set "WORD=%%w"
)

set /a "LIVES=6"
set "GUESSED="

REM Build blank display
set "DISPLAY="
for /l %%i in (1,1,!WORD:~-1!) do set "DISPLAY=!DISPLAY!_ "
set /a "WLEN=0"
set "TMPWORD=!WORD!"
:count_len
if not "!TMPWORD!"=="" (
    set "TMPWORD=!TMPWORD:~1!"
    set /a "WLEN+=1"
    goto :count_len
)

:game_loop
cls
echo.
echo   Hangman  ^|  Lives: !LIVES!  ^|  Guessed: !GUESSED!
echo.

REM Simple gallows
if !LIVES! EQU 6 echo      +---+  &echo      ^|   ^|  &echo          ^|  &echo          ^|  &echo          ^|  &echo     =========
if !LIVES! EQU 5 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo          ^|  &echo          ^|  &echo     =========
if !LIVES! EQU 4 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo      ^|   ^|  &echo          ^|  &echo     =========
if !LIVES! EQU 3 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo     /^|   ^|  &echo          ^|  &echo     =========
if !LIVES! EQU 2 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo     /^|\  ^|  &echo          ^|  &echo     =========
if !LIVES! EQU 1 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo     /^|\  ^|  &echo     /    ^|  &echo     =========
if !LIVES! EQU 0 echo      +---+  &echo      ^|   ^|  &echo      O   ^|  &echo     /^|\  ^|  &echo     / \  ^|  &echo     =========

echo.

REM Build current display string
set "SHOW="
for /l %%p in (0,1,!WLEN!) do (
    set "LETTER=!WORD:~%%p,1!"
    echo !GUESSED! | findstr /i "!LETTER!" >nul
    if !errorlevel! EQU 0 (
        set "SHOW=!SHOW!!LETTER! "
    ) else (
        set "SHOW=!SHOW!_ "
    )
)
echo   Word: !SHOW!
echo.

REM Check win
echo !SHOW! | findstr "_" >nul
if !errorlevel! NEQ 0 (
    echo   You win! The word was !WORD!
    goto :end
)

if !LIVES! EQU 0 (
    echo   You lose! The word was !WORD!
    goto :end
)

set /p "GUESS=  Guess a letter: "
set "GUESS=!GUESS:~0,1!"
if "!GUESS!"=="" goto :game_loop

REM Check if already guessed
echo !GUESSED! | findstr /i "!GUESS!" >nul
if !errorlevel! EQU 0 (
    echo   Already guessed that!
    ping -n 2 127.0.0.1 >nul
    goto :game_loop
)

set "GUESSED=!GUESSED!!GUESS! "

echo !WORD! | findstr /i "!GUESS!" >nul
if !errorlevel! NEQ 0 (
    set /a "LIVES-=1"
    echo   Not in word!
    ping -n 1 127.0.0.1 >nul
)

goto :game_loop

:end
echo.
set /p "R=  Play again? (Y/N): "
if /i "!R!"=="Y" (endlocal & call "%~f0" %1) else echo   Bye!
endlocal
