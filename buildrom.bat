@echo off
if exist temp rmdir /s /q temp
if exist bin rmdir /s /q bin
call make clean
call make -j13
if exist bin\POCKETDASH.gb (echo Build OK: bin\POCKETDASH.gb)
pause