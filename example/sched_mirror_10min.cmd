@echo off
::Usage: sched_mirror_10min.cmd
::Create mirror backup every 10 mins task in Scheduler. Task runs as SYSTEM and will execute even if user is not logged in.
::Has no access to mapped drives, only local resources.
::Note: must rightclick -> Run as admin to create the task.
pushd "%~dp0"
setlocal
schtasks /create /tn "Backup_mirror_10min" /sc DAILY /st 0:0 /ri 10 /du 24:00 /tr "'%cd%\backup_mirror.cmd'" /RU SYSTEM /np
popd
timeout /t 10