@echo off
setlocal EnableDelayedExpansion
title WiFi Info

echo ============================================================
echo   WiFi Information
echo ============================================================
echo.

REM Get connected SSID
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /i "SSID" ^| findstr /v "BSSID"') do (
    set "ssid=%%a"
    set "ssid=!ssid:~1!"
    goto :found_ssid
)
:found_ssid

REM Get signal strength
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interfaces ^| findstr /i "Signal"') do (
    set "signal=%%a"
    set "signal=!signal:~1!"
)

REM Get IP address
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "IPv4"') do (
    set "ip=%%a"
    set "ip=!ip:~1!"
    goto :found_ip
)
:found_ip

REM Get gateway
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /i "Default Gateway"') do (
    set "gw=%%a"
    set "gw=!gw:~1!"
    goto :found_gw
)
:found_gw

echo   SSID     : !ssid!
echo   Signal   : !signal!
echo   IPv4     : !ip!
echo   Gateway  : !gw!
echo.

REM Show signal bar
set "bar="
for /l %%i in (1,10,!signal:~0,-1!) do set "bar=!bar!#"
echo   Signal   : [!bar!] !signal!

echo.
echo ============================================================
endlocal
