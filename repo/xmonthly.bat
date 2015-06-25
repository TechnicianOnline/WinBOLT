@echo off

REM Chocolatey Package Manager Update
choco update -y

REM Chocolatey Application Updates
choco update all -y

REM Windows Updates
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\monthly_windows_update.log
copy "C:\WinBOLT\monthly_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Monthly_Windows_Update.log"

REM CCleaner Autorun
cd C:\Program Files\CCleaner\
ccleaner.exe /clean

REM Sophos CLI scanner
del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Sophos\"
svrtcli.exe -yes -debug
copy "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Sophos_Scan.log"

REM Emsisoft CLI Scanner
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
Set output=File Scan_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.txt
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\" /d
exit
