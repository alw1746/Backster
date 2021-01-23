@echo off
::Usage: restore.cmd [zipfile.7z]
::Performs full restore using 7Zip.
::Modify setup.cmd for your installation.
setlocal
pushd "%~dp0"
call setup.cmd
set startTime=%time%
set status=1
set EMAIL_ALERT=0
set MSG_ALERT=1

if [%1] == [] (
  echo No archive filename specified.
  echo Usage: restore.cmd [zipfile.7z]
  goto finish
) else (
  set infile=%1
)

::Change variables for your archive file name and restore folder.
::aoa=overwrite oldfile, aos=skip(do not restore existing), aou=rename newfile_n, aot=rename oldfile_n
set from_zipfile=%BCKSTR_HOME%\save\%infile%
set restore_to=%BCKSTR_HOME%\restore
set overwriteflag=-aoa
set logfile=restore_%infile%.log
IF EXIST "%logfile%" DEL /F "%logfile%"
echo Restore from %from_zipfile% >> %logfile%
echo To %restore_to% %overwriteflag% >> %logfile%

call :dorestore "%from_zipfile%" "%restore_to%" %overwriteflag% >> %logfile%
IF %ERRORLEVEL% EQU 0 set status=0

:finish
echo RESTORE STATUS: %status% (0=pass,1=fail) >> "%logfile%"
echo Start : %startTime% >> "%logfile%"
echo Finish: %time% >> "%logfile%"
set alertmsg=Restore %infile% completed, status: %status%
if %status% EQU 0 (
  if %EMAIL_ALERT% EQU 1 "%BCKSTR_HOME%\MailAlert\MailAlert.exe" -s "%alertmsg%" -b "%alertmsg%" -d  >> "%logfile%"
  if %MSG_ALERT% EQU 1 "%BCKSTR_HOME%\MsgAlert\Popup.cmd" "%alertmsg%"  >> "%logfile%"
)
popd
exit /b %status%

:dorestore
"%BCKSTR_7z%" x %1 -o%2 %3
exit /b %ERRORLEVEL%
endlocal
