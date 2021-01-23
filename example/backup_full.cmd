@echo off
::Usage: backup_full.cmd [DAILY|WEEKLY|MONTHLY]
::Performs full backup using 7Zip. Deletes previous zipfile before creating new archive. Useful for
::daily or weekly full backups. Archive file name has a suffix so past backups are
::available depending on suffix used in the cycle eg. _Tue(weekly) or _Apr(monthly).
::Note: setup.cmd must be customised to your installation.
setlocal
pushd "%~dp0"
call setup.cmd
set startTime=%time%
set status=1
set suffix=
set EMAIL_ALERT=0
set MSG_ALERT=0

IF EXIST backup_full_error.log DEL /F backup_full_error.log
if [%1] == [] (
  echo Missing parameter DAILY, WEEKLY or MONTHLY > backup_full_error.log
  goto finish
)
if /I "%1" == "DAILY" set suffix=daily_%BCKSTR_WKDAYNAME%
if /I "%1" == "WEEKLY" set suffix=weekly_%BCKSTR_WKDAYNAME%
if /I "%1" == "MONTHLY" set suffix=monthly_%BCKSTR_MONTHNAME%
if not defined suffix (
  echo Invalid parameter "%1" found.> backup_full_error.log
  goto finish
)

::Change variables for your backup source files and archive file name.
set backup_from=%BCKSTR_HOME%\test\*
set to_zipfile=%BCKSTR_HOME%\save\test_full_%suffix%.7z
set logfile=test_full_%suffix%.log
echo Full backup from %backup_from% > "%logfile%"
echo to %to_zipfile% >> "%logfile%"

call :dobackup "%backup_from%" "%to_zipfile%" >> "%logfile%"
IF %ERRORLEVEL% EQU 0 set status=0

:finish
echo BACKUP STATUS: %status% (0=pass,1=fail) >> "%logfile%"
echo Start : %startTime% >> "%logfile%"
echo Finish: %time% >> "%logfile%"
set alertmsg=Archive test_full_%suffix%.7z completed, status: %status%
if %status% EQU 1 (
  if %EMAIL_ALERT% EQU 1 "%BCKSTR_HOME%\MailAlert\MailAlert.exe" -s "%alertmsg%" -b "%alertmsg%" -d  >> "%logfile%"
  if %MSG_ALERT% EQU 1 "%BCKSTR_HOME%\MsgAlert\Popup.cmd" "%alertmsg%"  >> "%logfile%"
)
popd
exit /b %status%

:dobackup
IF EXIST %2 DEL /F %2
"%BCKSTR_7z%" a %2 %1
exit /b %ERRORLEVEL%
endlocal
