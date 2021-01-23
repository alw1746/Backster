@echo off
::Usage: sched_full_weekly.cmd
::Create full weekly backup task in Scheduler. Task runs as SYSTEM and will execute even if user is not logged in.
::Has no access to mapped drives, only local resources.
::Note: must rightclick -> Run as admin to create the task.
pushd "%~dp0"
setlocal
schtasks /create /tn "Backup_full_weekly" /sc WEEKLY /D THU /st 15:10  /tr "'%cd%\backup_full.cmd' WEEKLY" /RU SYSTEM /np
popd
timeout /t 10
