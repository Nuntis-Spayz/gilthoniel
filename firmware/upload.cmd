@pushd %~dp0
@cd %~dp0
@echo --------------------------------------
@if "%~1"=="" goto blank
@echo Uploading %1
@echo --------------------------------------
@echo.
tycmd upload %1
pause
exit

:blank
@echo Uploading OpenCore.1.9.13_20200714_json.hex
@echo -------------------------------------------
@echo.
tycmd upload OpenCore.1.9.13_20200714_json.hex
pause
exit
