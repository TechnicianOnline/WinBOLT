@echo off
choco update
cd C:\Program Files\CCleaner\
ccleaner.exe /clean
Cscript.exe C:\WinBOLT\winups.vbs > C:\WinBOLT\monthly_windows_update.log
REM Switch to the command line scanner directory to avoid issues with DLL loading
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
Set output=File Scan_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.txt
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\" /d
exit
