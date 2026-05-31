@echo off
setlocal EnableDelayedExpansion
title Tic Tac Toe

REM Board cells: 1-9
set "b1= " & set "b2= " & set "b3= "
set "b4= " & set "b5= " & set "b6= "
set "b7= " & set "b8= " & set "b9= "

set "TURN=X"
set /a "MOVES=0"

:game_loop
cls
echo.
echo   Tic Tac Toe
echo   -----------
echo.
echo    !b1! ^| !b2! ^| !b3!     7 ^| 8 ^| 9
echo   ----+---+----    ---+---+---
echo    !b4! ^| !b5! ^| !b6!     4 ^| 5 ^| 6
echo   ----+---+----    ---+---+---
echo    !b7! ^| !b8! ^| !b9!     1 ^| 2 ^| 3
echo.

call :check_win
if "!WIN!"=="1" (
    echo   Player !WINNER! wins!
    goto :end
)

if !MOVES! EQU 9 (
    echo   It's a draw!
    goto :end
)

:get_move
set /p "CELL=  Player !TURN!, pick a cell (1-9): "
if "!b%CELL%!" NEQ " " (
    echo   Cell taken, try again.
    goto :get_move
)

set "b!CELL!=!TURN!"
set /a "MOVES+=1"

if "!TURN!"=="X" (set "TURN=O") else (set "TURN=X")
goto :game_loop

:check_win
set "WIN=0"
REM Rows
for %%r in ("1 2 3" "4 5 6" "7 8 9") do (
    for /f "tokens=1,2,3" %%a in (%%r) do (
        if "!b%%a!"==!b%%b! if "!b%%b!"==!b%%c! if "!b%%a!" NEQ " " (
            set "WIN=1" & set "WINNER=!b%%a!"
        )
    )
)
REM Cols
for %%c in ("1 4 7" "2 5 8" "3 6 9") do (
    for /f "tokens=1,2,3" %%a in (%%c) do (
        if "!b%%a!"==!b%%b! if "!b%%b!"==!b%%c! if "!b%%a!" NEQ " " (
            set "WIN=1" & set "WINNER=!b%%a!"
        )
    )
)
REM Diagonals
if "!b1!"=="!b5!" if "!b5!"=="!b9!" if "!b1!" NEQ " " set "WIN=1" & set "WINNER=!b1!"
if "!b3!"=="!b5!" if "!b5!"=="!b7!" if "!b3!" NEQ " " set "WIN=1" & set "WINNER=!b3!"
goto :eof

:end
echo.
set /p "R=  Play again? (Y/N): "
if /i "!R!"=="Y" (endlocal & call "%~f0") else (echo   Bye!)
endlocal
