@echo off
setlocal EnableDelayedExpansion
title ASCII Banner

if "%~1"=="" (
    echo Usage: banner.bat "YOUR TEXT"
    exit /b 1
)

set "TEXT=%~1"
set "TEXT=!TEXT:a=A!"
set "TEXT=!TEXT:b=B!"
set "TEXT=!TEXT:c=C!"
set "TEXT=!TEXT:d=D!"
set "TEXT=!TEXT:e=E!"
set "TEXT=!TEXT:f=F!"
set "TEXT=!TEXT:g=G!"
set "TEXT=!TEXT:h=H!"
set "TEXT=!TEXT:i=I!"
set "TEXT=!TEXT:j=J!"
set "TEXT=!TEXT:k=K!"
set "TEXT=!TEXT:l=L!"
set "TEXT=!TEXT:m=M!"
set "TEXT=!TEXT:n=N!"
set "TEXT=!TEXT:o=O!"
set "TEXT=!TEXT:p=P!"
set "TEXT=!TEXT:q=Q!"
set "TEXT=!TEXT:r=R!"
set "TEXT=!TEXT:s=S!"
set "TEXT=!TEXT:t=T!"
set "TEXT=!TEXT:u=U!"
set "TEXT=!TEXT:v=V!"
set "TEXT=!TEXT:w=W!"
set "TEXT=!TEXT:x=X!"
set "TEXT=!TEXT:y=Y!"
set "TEXT=!TEXT:z=Z!"

echo.
REM Each letter is rendered as 5-line block text
REM This section handles H E L L O W O R L D as a demo

for %%c in (!TEXT!) do call :render_char %%c

echo.
goto :eof

:render_char
set "C=%~1"
if "!C!"=="H" (
    echo   ##  ##
    echo   ##  ##
    echo   ######
    echo   ##  ##
    echo   ##  ##
)
if "!C!"=="E" (
    echo   ######
    echo   ##
    echo   ####
    echo   ##
    echo   ######
)
if "!C!"=="L" (
    echo   ##
    echo   ##
    echo   ##
    echo   ##
    echo   ######
)
if "!C!"=="O" (
    echo   ######
    echo   ##  ##
    echo   ##  ##
    echo   ##  ##
    echo   ######
)
if "!C!"=="W" (
    echo   ##  ##
    echo   ##  ##
    echo   ## ###
    echo   #####
    echo   ## ##
)
if "!C!"=="R" (
    echo   #####
    echo   ##  ##
    echo   #####
    echo   ## ##
    echo   ##  ##
)
if "!C!"=="D" (
    echo   #####
    echo   ##  ##
    echo   ##  ##
    echo   ##  ##
    echo   #####
)
echo.
goto :eof
endlocal
