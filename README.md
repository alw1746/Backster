# Backster
Simple customisable tool to backup data into a 7-Zip archive using Windows scheduled tasks.
It is suitable for system administrators and programmers knowledgeable about Windows command line.

Test data, scripts and tasks are provided in an example folder.

Predefined backup types:
  full    create new archive every backup.
  mirror  update the archive to reflect disk content.

Predefined schedules:
  full daily, weekly, monthly.
  Mirror every 10 mins, hourly.

Installation
------------
-Unzip backster zipfile into a folder eg. C:\SOE\
-Backster consists of the following folders:

7-ZipPortable     7-Zip archiving software
doc               documentation
example           example scripts and tasks
MailAlert         send email utility.
MsgAlert          Popup and sound alert
restore           folder for test restores
save              folder for test backups
test              folder for test data

Files:

7-Zip.cmd          7-Zip shortcut
globals.cmd        global variable config for scripts
readme.txt         this file
TaskScheduler.cmd  Windows Task Scheduler shortcut

Getting started
---------------
Example data and scripts provides the capability to test 
the operations of the tool before performing actual backups.

Copy all example files to a working directory eg C:\tools\backups
Edit setup.com and point the globals.cmd line to your backstr installation eg:

call C:\SOE\Backster-1.0\globals.cmd

Backup
------
To create a daily task to perform a full backup of the test data,

Rightclick on sched_full_daily.cmd -> Run as administrator.

This will create a Windows scheduled task to run backup_full.cmd daily.
The task will run every day at 18:00 by default and backup the
test folder into save\test_full_daily_<weekday>.7z.
A log is created as test_full_daily_<weekday>.log.

To run the task immediately, run TaskScheduler.cmd,

Click on Task Scheduler Library (left pane)
Rightclick on Backup_full task (right pane) -> Run

The backup_full task will run immediately and the archive created in the save folder.

Restore
-------
run 7-Zip.cmd,

Navigate to save folder
Click on test_full_daily_<weekday>.7z
Click the Extract icon and set:
  Extract to: C:\SOE\Backster-1.0\restore
  Path mode: Full pathnames
  Overwrite mode: Overwrite without prompt
Click Ok

The test data will be restored to C:\SOE\Backster-1.0\restore\

Customisation
-------------
Example: full backup of D:\Word Files\*.docx into E:\archive\Word\ every day at 8:30pm.

Edit backup_full.cmd and change the lines to suit your setup:

set backup_from=D:\Word Files\*.docx
set to_zipfile=E:\archive\Word\Word_full_daily_%suffix%.7z

Edit sched_full_daily.cmd and change the start time to:

/st 20:30

Rightclick on sched_full_daily.cmd -> Run as administrator.
Enter Y to replace the existing task.

Perform an immediate run to check E:\archive\Word\Word_full_daily_<weekday>.7z exists.
Perform a restore to a temp folder to verify the files are available.

Alert notification
------------------
Alert messages can be sent using MailAlert in the event of a failure. The example below shows how to
configure a gmail address.

Edit MailAlert.ini,

[CONFIGURATION]
To=gmail_user@gmail.com        <== gmail address of receiver
From=gmail_user@gmail.com      <== gmail address of receiver
;ReplyTo=manager@example.org
;Cc=admin2@example.org,admin3@example.org
;Bcc=boss@example.org
FullName=Backster Alerts       <== informational
SMTPServer=smtp.gmail.com
SMTPPort=587
Username=gmail_user@gmail.com  <== google login username
EnableAutoTLS=yes
EnableSMTPS=no
Importance=High
PlaintextOnly=no
VerboseMode=no
Charset=ISO-8859-1
AlternativeSpaceEncoding=yes
Password=gmail_user_password   <== google login password

Send a test email with the command:

MailAlert -t

