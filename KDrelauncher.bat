@echo off
:loop
tasklist /fi "imagename eq adKDS30.exe" /fi "status eq running" | findstr /i "adKDS30.exe"
if %errorlevel% == 1 start "" "C:\Program Files (x86)\Aldelo\Aldelo For Restaurants\Aldelo Kitchen Display Server\adKDS30.exe"
tasklist /fi "imagename eq KCPManager.exe" /fi "status eq running" | findstr /i "KCPManager.exe"
if %errorlevel% == 1 start "" "C:\Users\Administrator\Desktop\KCPManager.exe"
timeout /t 10
cls
goto loop