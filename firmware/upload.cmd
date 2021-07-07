@pushd %~dp0
@cd %~dp0
set FNAME=OpenCore.2.0.2_20210512.hex

@echo.
@echo --------------------------------------
@echo OpenCore Saber Updater
@echo ---------- %FNAME%
@echo.

@tycmd list
@echo.
@echo The above list is all the compatible devices
@echo on your PC.
@echo An Anima-Evo saber should be listed as a Teensy 3.1
@echo board.
@echo.
@echo If there is more than one, remove the non-saber 
@echo devices before continuing. (Answer 'No' and re-run)
@echo.
@echo Flashing the saber firmware is done entirely at 
@echo your own risk.
@echo.
@echo Are You Sure you want to flash the firmware? [Y/N]
@choice /c YN
@if %errorlevel%==1 goto yes
@if %errorlevel%==2 goto no
:yes

@echo --------------------------------------
@if "%~1"=="" goto default
@echo Uploading %1
@echo --------------------------------------
@echo.
tycmd upload "%1"
pause
exit

:default
@echo Uploading %FNAME%
@echo --------------------------------------
@echo.
tycmd upload %FNAME%

:no
pause
exit
