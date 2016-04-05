@echo off
:: Version 1.2
chdir C:\ProgramData\Aldelo
IF %errorlevel% == 1 md C:\ProgramData\Aldelo
for /f "tokens=1,2,3,4 delims=/ " %%a in ("%date%") do (
set week=%%a
set month=%%b
set year=%%c
set day=%%d
)
IF NOT EXIST C:\ProgramData\Aldelo\%userdomain%.d (
set /p database=Enter database name:
set /p server=Enter servername:
set /p location=Drag the EXRA.bat file location:
set /p save=Drag or enter the location you want to save:
goto start
:start
echo %database%,%server%,%location%,%save% > C:\ProgramData\Aldelo\%userdomain%.d
)
IF EXIST C:\ProgramData\Aldelo\%userdomain%.d (
IF NOT EXIST "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup" md "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup"
for /f "tokens=1,2,3,4 delims=," %%A in (%userdomain%.d) do (
set database=%%A
set server=%%B
set location=%%C
set save=%%D
goto new
:new
Choice /T 5 /D N /M "Would you like to start over"
IF %errorlevel% == 1 (
del /a "C:\ProgramData\Aldelo\%userdomain%.d"
schtasks /delete /tn "AldelodailyBackup" /f
exit
)
)
)
chdir "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup"
goto next
:next
schtasks /create /sc daily /tn "dailyBackup" /tr %location% /st 06:00 /f
sqlcmd -S %server% -E -Q "backup database %database% to disk = 'C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup\backup.bak' with format, name='back up'"
if not %errorlevel% == 0 (
set /p a= Backup Failed:
del C:\ProgramData\Aldelo\%userdomain%.d
schtasks /delete /tn "dailyBackup" /f
)
ren backup.bak %userdomain%_%week%-%month%-%year%-%day%-%time:~3,2%.bak
forfiles /p "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup" /m *.bak /d -5 /c "cmd /c del @file" 2>null
IF EXIST null del null
IF %save% NEQ "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup" (
chdir %save%
IF NOT EXIST "AutoBackup" md AutoBackup
copy "C:\ProgramData\Aldelo\Aldelo POS\Backup\AutoBackup\%userdomain%_%week%-%month%-%year%-%day%-%time:~3,2%.bak" "AutoBackup"
forfiles /p "AutoBackup" /m *.bak /d -5 /c "cmd /c del @file"
)