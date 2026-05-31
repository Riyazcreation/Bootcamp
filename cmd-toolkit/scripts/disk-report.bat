@echo off
setlocal EnableDelayedExpansion
title Disk Report

echo ============================================================
echo   Disk Usage Report
echo ============================================================
echo.
echo   Drive   Total    Free     Used     Status
echo   ------  -------  -------  -------  --------

for /f "tokens=1,2,3" %%a in ('wmic logicaldisk where drivetype^=3 get DeviceID^,FreeSpace^,Size /value ^| findstr "="') do (
    set "%%a"
)

for /f "tokens=2 delims==" %%a in ('wmic logicaldisk where drivetype^=3 get DeviceID /value ^| findstr "DeviceID"') do (
    set "DRIVE=%%a"

    for /f "tokens=2 delims==" %%b in ('wmic logicaldisk where "DeviceID='!DRIVE!'" get FreeSpace /value') do set "FREE=%%b"
    for /f "tokens=2 delims==" %%b in ('wmic logicaldisk where "DeviceID='!DRIVE!'" get Size /value') do set "SIZE=%%b"

    if defined SIZE if defined FREE (
        set /a "FREE_GB=!FREE:~0,-6! / 1000"
        set /a "SIZE_GB=!SIZE:~0,-6! / 1000"
        set /a "USED_GB=SIZE_GB - FREE_GB"
        set /a "PCT=USED_GB * 100 / SIZE_GB"

        if !PCT! GEQ 90 (
            set "STATUS=CRITICAL"
        ) else if !PCT! GEQ 75 (
            set "STATUS=WARNING "
        ) else (
            set "STATUS=OK      "
        )

        echo   !DRIVE!     !SIZE_GB! GB   !FREE_GB! GB   !USED_GB! GB   !STATUS! (!PCT!%%)
    )
)

echo.
echo ============================================================
endlocal
