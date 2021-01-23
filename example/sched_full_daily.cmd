@echo off
::Usage: sched_full_daily.cmd
::Create full daily backup task in Scheduler. Task runs as SYSTEM and will execute even if user is not logged in.
::Has no access to mapped drives, only local resources.
::Note: must rightclick -> Run as admin to create the task.
pushd "%~dp0"
setlocal
schtasks /create /tn "Backup_full_daily" /sc DAILY /st 15:05  /tr "'%cd%\backup_full.cmd' DAILY" /RU SYSTEM /np
popd
timeout /t 10
