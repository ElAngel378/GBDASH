@echo off
if exist temp rmdir /s /q temp
if exist bin rmdir /s /q bin
call make clean
call make -j8
if exist bin\GBDASH.gb (
    gbdk\bin\romusage.exe bin/GBDASH.gb
)
pause
