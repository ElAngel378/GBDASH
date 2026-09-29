@echo off
REM Build (and optionally run) the Game Gear port. Usage: build.bat [run]
if "%GBDK_DIR%"=="" set GBDK_DIR=C:\gbdk
if not exist build mkdir build
set SRCS=
for %%f in ("%~dp0src\*.c") do call set SRCS=%%SRCS%% "%%f"
"%GBDK_DIR%\bin\lcc.exe" -mz80:gg -Wf--opt-code-speed -o "%~dp0build\POCKETDASH.gg" %SRCS%
if errorlevel 1 exit /b 1
if "%1"=="run" start "" "C:\Users\soter\OneDrive\Documents\Mesen.exe" "%~dp0build\POCKETDASH.gg"