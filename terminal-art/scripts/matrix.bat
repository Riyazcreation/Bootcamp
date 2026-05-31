@echo off
REM Matrix-style falling characters in CMD
REM Press Ctrl+C to stop
setlocal EnableDelayedExpansion

title Matrix Rain
color 0a
mode con: cols=80 lines=30

set "CHARS=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ!@#$%%^&*"
set /a "LEN=44"

:loop
cls
for /l %%row in (1,1,25) do (
    set "LINE="
    for /l %%col in (1,1,78) do (
        set /a "R=!RANDOM! %% 5"
        if !R! EQU 0 (
            set /a "IDX=!RANDOM! %% LEN"
            for /f "tokens=!IDX! delims= " %%c in ("!CHARS!") do (
                set "LINE=!LINE!%%c"
            )
        ) else (
            set "LINE=!LINE! "
        )
    )
    echo !LINE!
)
ping -n 1 -w 80 127.0.0.1 >nul
goto loop

endlocal
