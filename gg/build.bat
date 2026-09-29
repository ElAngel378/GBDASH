@echo off
REM Build (and optionally run) the Game Gear port. Usage: build.bat [run]
REM Debug builds: set GG_EXTRA=-DDEBUG_START_PX=4160 -DDEBUG_GODMODE and GG_OUT=POCKETDASH_debug
REM (the debug ROM goes to a separate file so it never overwrites the normal build).
if "%GBDK_DIR%"=="" set GBDK_DIR=C:\gbdk
if "%GG_OUT%"=="" set GG_OUT=POCKETDASH
if not exist build mkdir build
set SRCS=
for %%f in ("%~dp0src\*.c") do call set SRCS=%%SRCS%% "%%f"
"%GBDK_DIR%\bin\lcc.exe" -mz80:gg -Wm-yo4 -Wf--opt-code-speed -Wl-m %GG_EXTRA% -o "%~dp0build\%GG_OUT%.gg" %SRCS%
if errorlevel 1 exit /b 1
if "%1"=="run" start "" "C:\Users\soter\OneDrive\Documents\Mesen.exe" "%~dp0build\%GG_OUT%.gg"