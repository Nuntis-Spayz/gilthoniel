@pushd %~dp0
@cd %~dp0
@echo.
@echo --------------------------------------
@echo OpenCore Saber Updater
@echo --------------------------------------
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
@echo Uploading OpenCore.1.9.17_20200930.hex
@echo --------------------------------------
@echo.
tycmd upload OpenCore.1.9.17_20200930.hex

:no
pause
exit
