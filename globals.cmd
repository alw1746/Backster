set BCKSTR_HOME=%~dp0
set BCKSTR_HOME=%BCKSTR_HOME:~0,-1%
set BCKSTR_7Z=%BCKSTR_HOME%\7-ZipPortable\App\7-Zip64\7z.exe
set daysofweek=Mon,Tue,Wed,Thu,Fri,Sat,Sun  
for /F "skip=2 tokens=2-4 delims=," %%A in ('WMIC Path Win32_LocalTime Get DayOfWeek /Format:csv') do set BCKSTR_WKDAYNUM=%%A
for /F "tokens=%BCKSTR_WKDAYNUM% delims=," %%B in ("%daysofweek%") do set BCKSTR_WKDAYNAME=%%B

for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set dt=%%a
set BCKSTR_YYYY=%dt:~0,4%
set BCKSTR_MON=%dt:~4,2%
if %BCKSTR_MON%==01 set BCKSTR_MONTHNAME=Jan
if %BCKSTR_MON%==02 set BCKSTR_MONTHNAME=Feb
if %BCKSTR_MON%==03 set BCKSTR_MONTHNAME=Mar
if %BCKSTR_MON%==04 set BCKSTR_MONTHNAME=Apr
if %BCKSTR_MON%==05 set BCKSTR_MONTHNAME=May
if %BCKSTR_MON%==06 set BCKSTR_MONTHNAME=Jun
if %BCKSTR_MON%==07 set BCKSTR_MONTHNAME=Jul
if %BCKSTR_MON%==08 set BCKSTR_MONTHNAME=Aug
if %BCKSTR_MON%==09 set BCKSTR_MONTHNAME=Sep
if %BCKSTR_MON%==10 set BCKSTR_MONTHNAME=Oct
if %BCKSTR_MON%==11 set BCKSTR_MONTHNAME=Nov
if %BCKSTR_MON%==12 set BCKSTR_MONTHNAME=Dec
set BCKSTR_DD=%dt:~6,2%
set BCKSTR_HH=%time:~0,2%
if "%BCKSTR_HH:~0,1%" == " " set BCKSTR_HH=0%BCKSTR_HH:~1,1%
set BCKSTR_MM=%time:~3,2%
if "%BCKSTR_MM:~0,1%" == " " set BCKSTR_MM=0%BCKSTR_MM:~1,1%
set BCKSTR_SS=%time:~6,2%
if "%BCKSTR_SS:~0,1%" == " " set BCKSTR_SS=0%BCKSTR_SS:~1,1%
