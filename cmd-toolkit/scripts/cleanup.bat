@echo off
setlocal EnableDelayedExpansion
title System Cleanup

echo ============================================================
echo   System Cleanup
echo ============================================================
echo.
echo This will delete:
echo   - %%TEMP%% files
echo   - Windows Temp folder
echo   - Recycle Bin
echo   - Prefetch cache
echo.
set /p "CONFIRM=Continue? (Y/N): "
if /i not "!CONFIRM!"=="Y" (
    echo Cancelled.
    exit /b 0
)

echo.
echo [1/4] Clearing user temp...
del /q /f /s "%TEMP%\*" 2>nul
for /d %%i in ("%TEMP%\*") do rd /s /q "%%i" 2>nul
echo       Done.

echo [2/4] Clearing Windows temp...
del /q /f /s "%WINDIR%\Temp\*" 2>nul
for /d %%i in ("%WINDIR%\Temp\*") do rd /s /q "%%i" 2>nul
echo       Done.

echo [3/4] Emptying Recycle Bin...
rd /s /q "C:\$Recycle.Bin" 2>nul
echo       Done.

echo [4/4] Clearing Prefetch (requires admin)...
del /q /f /s "%WINDIR%\Prefetch\*" 2>nul
echo       Done.

echo.
echo ============================================================
echo   Cleanup complete!
echo ============================================================
endlocal
