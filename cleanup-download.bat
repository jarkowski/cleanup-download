@echo off

REM Change directory to the Downloads folder
cd /d "C:\Users\David\Downloads"

REM Set the location for the cleanup log file to be in the same folder as this script
set "LogFile=%~dp0cleanuplog.txt"

REM Extract date parts based on DD.MM.YYYY format:
set "Day=%date:~0,2%"
set "Month=%date:~3,2%"
set "Year=%date:~6,4%"
set "TodayFolder=OLD\%Year%-%Month%-%Day%"

REM Create OLD if it doesn’t exist
if not exist OLD (
    mkdir OLD
)

REM Create subfolder for today's date if it doesn’t exist
if not exist "%TodayFolder%" (
    mkdir "%TodayFolder%"
)

REM Loop through items in this directory, excluding the OLD folder
for /f "delims=" %%A in ('dir /b /a') do (
    if /I "%%~A" neq "OLD" (
        echo Moving "%%~A" to %TodayFolder%...
        (echo [%date% %time%] Moved "%%~A" to %TodayFolder%.)>>"%LogFile%"
        move "%%~A" "%TodayFolder%"
    )
)

echo Done!
timeout 5
