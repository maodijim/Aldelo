@echo off 
::Version 1.2
:restart
chdir "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup"
IF %errorlevel% == 1 md "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup"
for /f "tokens=1,2,3,4 delims=/ " %%a in ("%date%") do (
set week=%%a
set month=%%b
set year=%%c
set day=%%d
)
IF NOT EXIST "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t" (
set /p database=Drag or enter the .mdb file location:
set /p location=Drag or enter Aldelo-backupDatabase file location:
set /p save=Drag or enter the location you want to save:
goto start
:start
echo %database%,%location%,%save% > "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t"
) 
IF EXIST "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t" (
chdir "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup"
for /f "tokens=1,2,3 delims=," %%A in (aldelo.t) do (
set database=%%A
set location=%%B
set save=%%C
IF NOT EXIST %database% (
del /a "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t"
goto restart 
)
goto new
:new
Choice /T 5 /D N /M "Would you like to start over"
IF %errorlevel% == 1 (
del /a "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t"
schtasks /delete /tn "AldelodailyBackup" /f
exit
)
)
)

goto next
:next
schtasks /create /sc daily /tn "AldelodailyBackup" /tr %location% /st 06:30 /f
IF NOT EXIST "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\AutoBackup" md "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\AutoBackup"
chdir "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\AutoBackup"
copy %database% %userdomain%-Aldelo_%week%-%month%-%year%-%day%-%time:~3,2%.mdb
IF NOT %errorlevel% == 0 (
del /a "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\aldelo.t"
set /p a= Backup Failed:
schtasks /delete /tn "AldelodailyBackup" /f
)
forfiles /p "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\AutoBackup" /m *.mdb /d -5 /c "cmd /c del @file" 2>null
IF EXIST null del null
IF %save% NEQ "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup" (
chdir %save%
IF NOT EXIST AutoBackup md AutoBackup
copy "C:\ProgramData\Aldelo\Aldelo For Restaurants\Backup\AutoBackup\%userdomain%-Aldelo_%week%-%month%-%year%-%day%-%time:~3,2%.mdb" AutoBackup
forfiles /p AutoBackup /m *.mdb /d -5 /c "cmd /c del @file" 2>null
IF EXIST null del null
)
