@echo off
::Usage: sched_mirror_hourly.cmd
::Create mirror backup hourly task in Scheduler. Task runs as SYSTEM and will execute even if user is not logged in.
::Has no access to mapped drives, only local resources.
::Note: must rightclick -> Run as admin to create the task.
pushd "%~dp0"
setlocal
schtasks /create /tn "Backup_mirror_hourly" /sc HOURLY /st 15:30 /tr "'%cd%\backup_mirror.cmd'" /RU SYSTEM /np
popd
timeout /t 10