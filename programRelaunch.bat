@echo off
:loop
tasklist /fi "imagename eq winword.exe" | findstr /i "winword.exe"
if %errorlevel% == 1 start C:\Users\Andy\Desktop\¼ò½é.doc
timeout /t 10
cls
goto loop