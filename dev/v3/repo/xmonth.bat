@echo off

REM Rkill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"

REM TDRSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"

REM CCleaner Autorun
cd C:\Program Files\CCleaner\
ccleaner.exe /clean

REM Emsisoft CLI Scanner
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Emsisoft_Scan.log"

REM Windows Updates
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\monthly_windows_update.log
copy "C:\WinBOLT\monthly_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Monthly_Windows_Update.log"

REM Chocolatey Package Manager Update
choco update -y

REM Chocolatey Application Updates
choco update all -y
exit
