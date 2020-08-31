@pushd %~dp0
@cd %~dp0
@echo.
@echo --------------------------------------
@echo OpenCore Saber Updater
@echo --------------------------------------
@echo.
@echo --------------------------------------
@if "%~1"=="" goto default
@echo Uploading %1
@echo --------------------------------------
@echo.
tycmd upload "%1"
pause
exit

:default
@echo Uploading OpenCore.1.9.15_20200820.hex
@echo --------------------------------------
@echo.
tycmd upload OpenCore.1.9.15_20200820.hex
pause
exit
