@echo off
setlocal enabledelayedexpansion

REM This script converts all .tmx files in levels/chr_data/tmx to GBDK-compatible level files.

pushd "%~dp0"

set /a bank=128

for %%f in (levels\chr_data\tmx\*.tmx) do (
    set "name=%%~nf"
    echo Processing !name! into bank !bank!...

    REM 1. Extract background tile map (16 metatiles high, bottom-aligned, column-major bin)
    python tools\csv2level.py "%%f" -o levels\level_data\ -n !name!_16high --crop-height 16 --bottom --no-c --no-h

    REM 2. Extract sprites and portals into C source
    python tools\tmx2sprites.py "%%f" -o src\ -n !name! -b !bank!

    set /a bank-=1
)

popd
echo.
echo Conversion complete.
pause
