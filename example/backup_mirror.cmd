@echo off
::Usage: backup_mirror.cmd
::Updates zipfile to mirror any changes in source dir eg file change,addition,deletion. Useful for
::intraday backups eg. hourly or if full backup of large source dir takes too long.
::Note: setup.cmd must be customised to your installation.
setlocal
pushd "%~dp0"
call setup.cmd
set startTime=%time%
set status=1
set EMAIL_ALERT=0
set MSG_ALERT=1

IF EXIST backup_mirror_error.log DEL /F backup_mirror_error.log

::Change variables for your backup source files and archive file name.
set backup_from=%BCKSTR_HOME%\test\*
set to_zipfile=%BCKSTR_HOME%\save\test_mirror.7z
set logfile=test_mirror.log
echo Mirror backup from %backup_from% > "%logfile%"
echo to %to_zipfile% >> "%logfile%"

call :dobackup "%backup_from%" "%to_zipfile%" >> "%logfile%"
IF %ERRORLEVEL% EQU 0 set status=0

:finish
echo BACKUP STATUS: %status% (0=pass,1=fail) >> "%logfile%"
echo Start : %startTime% >> "%logfile%"
echo Finish: %time% >> "%logfile%"
set alertmsg=Archive test_mirror.7z completed, status: %status%
if %status% EQU 0 (
  if %EMAIL_ALERT% EQU 1 "%BCKSTR_HOME%\MailAlert\MailAlert.exe" -s "%alertmsg%" -b "%alertmsg%" -d  >> "%logfile%"
  if %MSG_ALERT% EQU 1 "%BCKSTR_HOME%\MsgAlert\Popup.cmd" "%alertmsg%" >> "%logfile%"
)
popd
exit /b %status%

:dobackup
"%BCKSTR_7z%" u -up1q0r2x1y2z1w2 %2 %1
::"%BCKSTR_7z%" t %2
exit /b %ERRORLEVEL%
endlocal
