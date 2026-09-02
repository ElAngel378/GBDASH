@echo off
setlocal

pushd "%~dp0"

echo ===================================================
echo Converting all TMX levels, sprites, music, and VRAM...
echo ===================================================
python tools\build_levels.py

popd
echo.
echo Conversion complete!
echo Running make...
make -j8
pause
