@echo off
::Usage: sched_full_monthly.cmd
::Create full monthly backup task in Scheduler. Task runs as SYSTEM and will execute even if user is not logged in.
::Has no access to mapped drives, only local resources.
::Note: must rightclick -> Run as admin to create the task.
pushd "%~dp0"
setlocal
schtasks /create /tn "Backup_full_monthly" /sc MONTHLY /D 21 /st 14:45  /tr "'%cd%\backup_full.cmd' MONTHLY" /RU SYSTEM /np
popd
timeout /t 10