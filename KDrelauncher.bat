@echo off
::v1.1
:loop

tasklist /fi "imagename eq adKDS30.exe" /fi "status eq NOT RESPONDING" | findstr /i "adKDS30.exe"
if %errorlevel% == 0 taskkill /F /FI "imagename eq adKDS30.exe" /fi "status eq NOT RESPONDING"
tasklist /fi "imagename eq adKDS30.exe" /fi "status eq RUNNING" | findstr /i "adKDS30.exe"
if %errorlevel% == 1 start "" "C:\Program Files (x86)\Aldelo\Aldelo For Restaurants\Aldelo Kitchen Display Server\adKDS30.exe"

tasklist /fi "imagename eq KCPManager.exe" /fi "status eq NOT RESPONDING" | findstr /i "KCPManager.exe"
if %errorlevel% == 0 taskkill /F /FI "imagename eq KCPManager.ex" /fi "status eq NOT RESPONDING"
tasklist /fi "imagename eq KCPManager.exe" /fi "status ne running"| findstr /i "KCPManager.exe"
if %errorlevel% == 1 start "" "C:\Users\Administrator\Desktop\KCPManager.exe"

@echo.
echo Don't Close this Program. It re-launch kitchen display if close.
timeout /t 10
cls
goto loop