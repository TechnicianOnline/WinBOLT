@echo off
mode con:cols=90 lines=30
REM ###################################################################################################################
REM ######################################### ( - WinBOLT Creator - ) #################################################
REM ###################################################################################################################
REM License: GNU GENERAL PUBLIC LICENSE
REM Created by Christian Vazquez
REM Email:Christian_V@live.com 
REM Github.com/OnlineLabs
REM Created 12/13/14
REM ###################################################################################################################
REM ####################################### ( - Current Version and Info - ) ##########################################
REM ###################################################################################################################
SET LAST_UPDATED=06.16.2015
SET Current_Version=3.0
SET wsize=10096
REM ###################################################################################################################
REM ######################################## ( - Change Log and Version - ) ###########################################
REM ###################################################################################################################
REM **v.02: Added Registry Entry to disable UAC.
REM **v.02: Added ccleaner monthly autoscheduler with customer config .INI file (Does NOT delete cookies).
REM **v.02: Added "Maintenance Script Autoschedule to Menu" runs every 30th and 15th of the month.
REM **v.02: Added malwarebytes to Autoschedule, silent quick scan and threat removal (if found). Non-silent update.
REM **v.02: Added second BATCH script (Monthly.bat) to Windows BOLT.
REM **v.03: Added SelfAdminTest to BOLT.
REM **v.03: Added rename.vbs script to change Computer Host Name.
REM **v.03: Removed all Registry Apps.
REM **v.03: Added third BATCH script (repos.bat), option settings for user.
REM **v.03: Added fourth BATCH script (Monthly_VB.VBS), runs Monthly.bat silently.
REM **v.04: Added HardwareInfo sub-menu.
REM **v.04: Restructured entire Menu options.
REM **v.04: Refined batch script.
REM **v.04: Changed name from Windows Bolt to WinBOLT.
REM **v.04: Removed MBAM and replaced with Emsisoft EEK.
REM **v.04: Added emsisoft.bat, emsisoft_VB.vbs and EEK folder.
REM **v.04: Refined Monthly.bat.
REM **v.04: Added Custom Applications sub-menu.
REM **v.04: Added Uninstall option to Custom Applications sub-menu.
REM **v.04: Added autoscheduler reboot to FSC.
REM **v.04: Merged emsisoft.bat with monthly.bat, removed emsisoft_VB.vbs and emsisoft.bat.
REM **v1.0: extracts all files to TEMP and moves to C:\WinBOLT\.
REM **v1.0: revised code, audited all entries and uploaded to github.com/OnlineLabs.
REM **v1.0: Added Windows Updates to Option #2 and Option#7.
REM **v1.0: Fixed WinBOLT hang, verficiation check added before ROBOCOPY.
REM **v1.0: Added SSD defrag manuel bypass for Option #6 and #7.
REM **v1.0: Major additions to hardware info Option #9.
REM **v1.0: Added option #10 Backup User Account and Windows Serial Key.
REM **v2.0: Added option #11 Extract Windows Serial Key.
REM **v2.0: Added wink.vbs and winkpop.vbs.
REM **v2.0: Fixed Windows update in option #2 and #7, added winups.vbs.
REM **v2.0: Re-worded important options.
REM **v2.0: Swapped option #3 to option #7.
REM **v2.0: Dropped option #4,#5,#6,#7 by one number as #3,#4,#5,#6.
REM **v2.0: Added a SSD/HDD checker for option #6 and #5 to remove users prompt for input.
REM **v2.0: Fixed script execution for wink.vbs and winkpop.vbs.
REM **v2.0: Added spool clear command in option #4 and #6.
REM **v2.0: Silent custom apps install and uninstsall execution.
REM **v2.0: Added UAC reg entry in the begining of the script.
REM **v2.0: Windows Update Output with timestamp added.
REM **v2.0: renamed WinBOLT.bat to WinBOLT.cmd.
REM **v2.0: release offical v2.0 on sourceforge.
REM **v2.0: Added WinBOLT.cmd to native commandline path to execute.
REM **v2.0: Improved Backup Script.
REM **v2.0: Improved hardware script
REM **v3.0: added sophos scanner engine
REM **v3.0: adjusted monthly maintenance to 10PM each 1/16
REM **v3.0: added offical license and TAC
REM **v3.0: Updated documentation/guide
REM **v3.0: placed support scripts within repo directory.
REM **v3.0: Updated monthly.bat to xmonth.bat with improvments.
REM **v3.0: added desktop shortcut
REM **v3.0: added vipre scanner
REM ###################################################################################################################
REM ###################################################################################################################

color 5
title (- WinBOLTv%Current_Version% - GitHub.com/OnlineLabs -)

:shortcut
IF EXIST %USERPROFILE%\Desktop\WinBOLT.lnk (
    1>nul 2>nul del /f %USERPROFILE%\Desktop\WinBOLT.lnk
) else (
    goto copy
)

:copy
IF EXIST C:\WinBOLT\Backups\Logs GOTO fileman
1>nul 2>nul md C:\WinBOLT\
1>nul 2>nul md C:\WinBOLT\Backups
1>nul 2>nul md C:\WinBOLT\Backups\Logs

:fileman
1>nul 2>nul del /f C:\WinBOLT\README.md
1>nul 2>nul del /f C:\WinBOLT\monthly.bat
1>nul 2>nul del /f C:\WinBOLT\monthly.vbs
1>nul 2>nul del /f C:\WinBOLT\repo\monthly.bat
1>nul 2>nul del /f C:\WinBOLT\repo\monthly.vbs
1>nul 2>nul del /f C:\Windows\System32\WinBOLT.cmd
1>nul 2>nul xcopy /Q /J /Y /Z "%0" "C:\Windows\System32\"
cls

:Verification

setlocal
for /f "tokens=4-5 delims=[.XP" %%i in ('ver') do set VERSION=%%i.%%j
REM Windows 10
if "%version%" == "10.0" goto power
REM Windows 8.1
if "%version%" == "6.3" goto power
REM Windows 8
if "%version%" == "6.2" goto power
REM Windows 7
if "%version%" == "6.1" goto uac
REM Windows Vista
if "%version%" == "6.0" goto uac
REM Windows XP
if "%version%" == "5.1" goto uac
endlocal

:uac
REM This will disable UAC. It's required for WinBOLT but not needed on Windows 8 and above.
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0x0 /f

:power
REM This will disable all sleep/hibernation/monitor timeout counters.
powercfg -change -monitor-timeout-ac 0
powercfg -change -standby-timeout-ac 0
powercfg -change -disk-timeout-ac 0
powercfg -change -hibernate-timeout-ac 0


cls
color a
echo.
echo.
echo                Starting                              .//+/-..:s     
echo                   WinBOLT                         `:/+:`       y`    
echo                       v%Current_Version%                    ./+/.`            h`    
echo                                             `/+/`    `        `h     
echo                                            :+/.   .ossoss:     +:     
echo                                        `/+-`    .d:`   .h+   `y      
echo                             `.--::::--+/.       oy      :m   s.      
echo                      `-://+/::-..../s/`         -m-    `yo  /+       
echo                   .:+/-.`        .+/`         `` -ss++os/  -s        
echo                 .o/.`          `+/`        `/+/o:  `...   .y`        
echo                 -o/:--.       -o.        `/o-  /+        .y`         
echo                   `.--:+/:-` /+`        -o:   :s`       .s.          
echo                         `.:/os        `++`  `++`       .s.           
echo                             `+/`     :o.   -o-        -s`            
echo                               -s:` `o/   .+/`        /d`             
echo                             `:+/:s/s-  `++.        `o//+             
echo                            :o-  /+h. `/o.         -o.  d             
echo                           /o   +/y``:oy.`       .+/    d             
echo                           h`  .oh-/o/+.:y/.`  .++`     h`            
echo                           h`  .oos+:-  :o`:/+o/.       h`            
echo                           o:   `.`    -y`   `o+        d             
echo                           s-   ````./+/       :s`     .y             
echo                          +o`-+/////-`          .y.    s:             
echo                         `d++-                   `y`  -y              
FOR /L %%n IN (1,1,10) DO ping 1 127.0.0.1 > nul & <nul set /p =.
timeout /t 1 >nul


:ToS
REM Terms as Stated
cls
color CF
echo.
echo  ####################################################
echo  # Read and approve the following before continuing #
echo  ####################################################
echo.
echo WinBOLT v%Current_Version%
echo Copyright (C) 2014  Christian Vazquez
echo.
echo This program is free software; you can redistribute it and/or modify
echo it under the terms of the GNU General Public License as published by
echo the Free Software Foundation; either version 2 of the License.
echo.
echo     This program is distributed in the hope that it will be useful,
echo     but WITHOUT ANY WARRANTY; without even the implied warranty of
echo     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo     GNU General Public License for more details.
echo.
echo [X] Product is licened under GNU General Public v2
echo [X] Full Local Administrator rights
echo [X] .NET Framework 3.5 and above
echo [X] PowerShell 2.0 and above
echo.
echo.
set /p op=Do you agree to the terms and conditions? (Y or N):
if %op%==Y goto SelfAdminTest
if %op%==Yes goto SelfAdminTest
if %op%==yes goto SelfAdminTest
if %op%==y goto SelfAdminTest
if %op%==N goto exit
if %op%==No goto exit
if %op%==no goto exit
if %op%==n goto exit
echo Incorrect input, try again.
timeout /t 1 >nul
goto ToS

REM Self Admin Check
:SelfAdminTest
1>nul 2>nul netstat -bno
IF %ERRORLEVEL% EQU 0 (
    cls
    color ca
    echo.
    ECHO                    Administrator rights verified.
    timeout /t 2 >nul
    GOTO menu
) ELSE (
    cls
    echo.
    ECHO                    You are NOT the Administrator. Closing.
    timeout /t 3 >nul
    EXIT /B 1
)

REM GREETING MENU
:menu
mode con:cols=90 lines=30
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ######################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - GitHub.com/OnlineLabs #
echo    ######################################################################
echo    (Last Updated: %Last_Updated%)
echo.
echo     1)  Install Chocolatey
echo     2)  Run Windows Update and Chocolatey Updates
echo     3)  Enable Maintenance Script (Runs Monthly Each 30th/15th)
echo     4)  Delete Temp, Run CCleaner, EEK update/scan/virus removal.
echo     5)  Defrag HDD, Sys File CHK, File Sys CHK (Auto reboot once completed)
echo     6) *All Of The Above - Full Blown System Maintenance
echo.
echo.    N)  Second Menu
echo     X)  Exit
echo.
echo.
echo.
set /p op=I Select Number #
if %op%==1  goto 1
if %op%==2  goto 2
if %op%==3  goto 3
if %op%==4  goto 4
if %op%==5  goto 5
if %op%==6  goto 6
if %op%==n  goto menu2
if %op%==N  goto menu2
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, please try again.
timeout /t 1 >nul
goto menu


:menu2
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ######################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - GitHub.com/OnlineLabs #
echo    ######################################################################
echo    (Last Updated: %Last_Updated%)
echo.
echo                        Second Menu - Misc Options
echo.
echo     7)  Install Custom Applications
echo     8)  Get Hardware Information
echo     9)  Special Tools & Actions
echo.
echo     I)  Information on WinBOLT
echo     R)  Return to the first menu
echo     X)  Exit WinBOLT
echo.
echo.
echo.
echo.
set /p op=I Select Number #
if %op%==7  goto 7
if %op%==8  goto 8
if %op%==9  goto menu3
if %op%==10 goto 10
if %op%==11 goto 11
if %op%==12 goto 12
if %op%==13 goto 13
if %op%==14 goto 14
if %op%==15 goto 15
if %op%==16 goto 16
if %op%==i goto intel
if %op%==I goto intel
if %op%==r goto menu
if %op%==R goto menu
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, try again.
timeout /t 1 >nul
goto menu2

:menu3
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ######################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - GitHub.com/OnlineLabs #
echo    ######################################################################
echo    (Last Updated: %Last_Updated%)
echo.
echo                        Special Tools & Actions Menu
echo.
echo    rename)  Rename Computer Host Name
echo    backup)  Backup User Account and Windows Serial Key (XP Not Supported)
echo    key)  Extract Windows Serial Key
echo    spool) Printer - Clear System Spools
echo    sophos) scan machine with sophos antivirus
echo    vipre) scan machine with vipre antivirus
echo    both) scan with both Vipre and Sophos
echo    
echo.
echo     I)  Information on WinBOLT
echo     R)  Return to the first menu
echo     X)  Exit WinBOLT
echo.
echo.
echo.
echo.
set /p op=I Select Number #
if %op%==7  goto 7
if %op%==8  goto 8
if %op%==9  goto 9
if %op%==10 goto 10
if %op%==11 goto 11
if %op%==12 goto 12
if %op%==13 goto 13
if %op%==14 goto 14
if %op%==15 goto 15
if %op%==16 goto 16
if %op%==i goto intel
if %op%==I goto intel
if %op%==r goto menu
if %op%==R goto menu
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, try again.
timeout /t 1 >nul
goto menu2


:1
cls

echo.
echo.
echo       Installing Chocolatey Please Wait!
echo.
echo.
echo.
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

cls
echo COMPLETED - Chocolatey Install
goto menu


:2
cls

echo.
echo.
echo       Running Chocolatey Updates, Please Wait!
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
choco update -y
choco update all -y
cls
echo.
echo Chocolatey and Apps finished updating.
echo.
FOR /L %%n IN (1,1,10) DO ping -n 2 127.0.0.1 > nul & <nul set /p =.
echo.
echo.
echo Currently scanning for Windows Updates
echo.
echo.
FOR /L %%n IN (1,1,10) DO ping -n 2 127.0.0.1 > nul & <nul set /p =.
echo.
echo.
echo Downloading/Installing Windows Updates, this might be a few hours!
echo.
echo.
echo Windows Update Output:
echo    C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log
echo.
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"


cls
echo COMPLETED - Update Windows and Chocolatey Apps
timeout /t 3 >nul
goto menu



:3
cls

echo.
echo.
echo       Installing Maintenance Script Autoschedule; Please Wait!
echo.
echo.

REM MONTHLY MAINTENANCE - 01TH AND 16TH OF MONTH at 10:00PM
1>nul 2>nul schtasks /delete /tn WinBOLT-Monthly-Maintenance /f
1>nul 2>nul SCHTASKS /Create /SC MONTHLY /D 01;16 /st 22:00 /TN "WinBOLT-Month-Maintenance" /TR "C:\WinBOLT\repo\xmonth.vbs" /RU "system" /RL HIGHEST /f


cls
echo COMPLETED - Maintenance Script Autoschedule
timeout /t 3 >nul
goto menu



:4
cls

echo.
echo.
echo       Windows Tune Up, Please Wait!
REM Installs CCleaner + custom config.int/Runs deep EEK virus scan/Updates/DelTempFiles
echo.
echo.
echo.
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
choco install ccleaner -y
cd     C:\Program Files\CCleaner\
(echo  [Options]) > ccleaner.ini
(echo  UpdateKey=01/19/2015 01:14:08 PM) >> ccleaner.ini
(echo  WipeFreeSpaceDrives=C:\) >> ccleaner.ini
(echo  CookiesToSave=) >> ccleaner.ini
(echo  RunICS=0) >> ccleaner.ini
(echo  CheckTrialOffer=0) >> ccleaner.ini
echo   (App)Cookies=False >> ccleaner.ini
echo   (App)Recently Typed URLs=False >> ccleaner.ini
echo   (App)Chkdsk File Fragments=False >> ccleaner.ini
echo   (App)Windows Error Reporting=True >> ccleaner.ini
echo   (App)Windows Log Files=True >> ccleaner.ini
echo   (App)DNS Cache=True >> ccleaner.ini
echo   (App)Font Cache=True >> ccleaner.ini
echo   (App)Start Menu Shortcuts=False >> ccleaner.ini
echo   (App)Windows Event Logs=False >> ccleaner.ini
echo   (App)Old Prefetch data=True >> ccleaner.ini
echo   (App)Tray Notifications Cache=False >> ccleaner.ini
echo   (App)Mozilla - Cookies=False >> ccleaner.ini
echo   (App)Mozilla - Internet History=False >> ccleaner.ini
echo   (App)Google Chrome - Cookies=False >> ccleaner.ini
echo   (App)Google Chrome - Internet History=False >> ccleaner.ini
echo   (App)Adobe Acrobat XI=False >> ccleaner.ini
echo   (App)Evernote=False >> ccleaner.ini
echo   (App)MS Office Picture Manager=True >> ccleaner.ini
echo   (App)Virtual Clone Drive=True >> ccleaner.ini
echo   (App)FileZilla=False >> ccleaner.ini
echo   (App)LogMeIn=False >> ccleaner.ini
echo   (App)Skype=False >> ccleaner.ini
echo   (App)Sublime Text=False >> ccleaner.ini
echo   (App)TeamViewer=False >> ccleaner.ini
echo   (App)Windows Defender=False >> ccleaner.ini
echo   (App)WinRAR=False >> ccleaner.ini
echo   (App)Remote Desktop=False >> ccleaner.ini
(echo  AnalyzerTypes=) >> ccleaner.ini
(echo  SystemAnalyzerDrives=C:\) >> ccleaner.ini
(echo  FinderInclude1=) >> ccleaner.ini
(echo  FinderIncludeStates=1) >> ccleaner.ini
(echo  UpdateCheck=0) >> ccleaner.ini
(echo  Monitoring=0) >> ccleaner.ini
(echo  SystemMonitoring=0) >> ccleaner.ini
(echo  DelayRB=1) >> ccleaner.ini
(echo  HideWarnings=1) >> ccleaner.ini
(echo  AutoClose=1) >> ccleaner.ini
(echo  BackupPrompt=0) >> ccleaner.ini
cd C:\Program Files\CCleaner\
ccleaner.exe /clean




cls
echo.
echo.
echo.
echo    ###############################################################
echo    -Running DEEP EmsiSoft EEK scan, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Emsisoft_Scan.log"



cls
echo COMPLETED - Windows Tune up!
timeout /t 3 >nul
goto menu


:5
cls
color a
for /F "tokens=1-2" %%a in ('wmic LogicalDisk get DeviceID^,DriveType') do (
   if "%%b" equ "3" (
      goto 5no
   )
)
set partitions=0
for /F "tokens=1-2" %%a in ('wmic DiskDrive get InterfaceType^,Partitions') do (
   if "%%a" equ "IDE" set /A partitions+=%%b
)
set drives=BCDEFGHIJKLMNOPQRSTUVWXYZ
call set lastIDEdrive=%%drives:~%partitions%,1%%:
echo Last IDE interface logical drive (B:=none): %lastIDEdrive%
for /F %%a in ('wmic LogicalDisk get DeviceID') do (
   if "%%a" gtr "%lastIDEdrive%" (
      goto 5yes
   )
)

:5no
echo.
echo.
echo       Defraging, File System Check, File System Integrity Check Entire System, Please Wait!
echo.
echo.
echo.
sfc /scannow
echo y|chkdsk /f /r C:
defrag c: /h /x
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600

:5yes
echo.
echo      Solid State Drive Detected - Skipping Defrag
echo.
echo      Running File System Check and File System Integrity Check, Please Wait!
echo.
echo.
echo.
sfc /scannow
echo y|chkdsk /f /r C:
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600


cls
echo.
echo COMPLETED - System will reboot in 10mins to complete changes to file system.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto CancelReboot
goto menu

:CancelReboot
shutdown /a
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto menu


:6
cls
color a
for /F "tokens=1-2" %%a in ('wmic LogicalDisk get DeviceID^,DriveType') do (
   if "%%b" equ "3" (
      goto 6no
   )
)
set partitions=0
for /F "tokens=1-2" %%a in ('wmic DiskDrive get InterfaceType^,Partitions') do (
   if "%%a" equ "IDE" set /A partitions+=%%b
)
set drives=BCDEFGHIJKLMNOPQRSTUVWXYZ
call set lastIDEdrive=%%drives:~%partitions%,1%%:
echo Last IDE interface logical drive (B:=none): %lastIDEdrive%
for /F %%a in ('wmic LogicalDisk get DeviceID') do (
   if "%%a" gtr "%lastIDEdrive%" (
      goto 6yes
   )
)

:6no
echo.
echo.
echo       Running EVERYTHING, please be patient this can take a few hours!
echo.
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
echo.
choco update -y
choco update all -y
choco install ccleaner -y
cd     C:\Program Files\CCleaner\
(echo  [Options]) > ccleaner.ini
(echo  UpdateKey=01/19/2015 01:14:08 PM) >> ccleaner.ini
(echo  WipeFreeSpaceDrives=C:\) >> ccleaner.ini
(echo  CookiesToSave=) >> ccleaner.ini
(echo  RunICS=0) >> ccleaner.ini
(echo  CheckTrialOffer=0) >> ccleaner.ini
echo   (App)Cookies=False >> ccleaner.ini
echo   (App)Recently Typed URLs=False >> ccleaner.ini
echo   (App)Chkdsk File Fragments=False >> ccleaner.ini
echo   (App)Windows Error Reporting=True >> ccleaner.ini
echo   (App)Windows Log Files=True >> ccleaner.ini
echo   (App)DNS Cache=True >> ccleaner.ini
echo   (App)Font Cache=True >> ccleaner.ini
echo   (App)Start Menu Shortcuts=False >> ccleaner.ini
echo   (App)Windows Event Logs=False >> ccleaner.ini
echo   (App)Old Prefetch data=True >> ccleaner.ini
echo   (App)Tray Notifications Cache=False >> ccleaner.ini
echo   (App)Mozilla - Cookies=False >> ccleaner.ini
echo   (App)Mozilla - Internet History=False >> ccleaner.ini
echo   (App)Google Chrome - Cookies=False >> ccleaner.ini
echo   (App)Google Chrome - Internet History=False >> ccleaner.ini
echo   (App)Adobe Acrobat XI=False >> ccleaner.ini
echo   (App)Evernote=False >> ccleaner.ini
echo   (App)MS Office Picture Manager=True >> ccleaner.ini
echo   (App)Virtual Clone Drive=True >> ccleaner.ini
echo   (App)FileZilla=False >> ccleaner.ini
echo   (App)LogMeIn=False >> ccleaner.ini
echo   (App)Skype=False >> ccleaner.ini
echo   (App)uTorrent=False >> ccleaner.ini
echo   (App)Sublime Text=False >> ccleaner.ini
echo   (App)TeamViewer=False >> ccleaner.ini
echo   (App)Windows Defender=False >> ccleaner.ini
echo   (App)WinRAR=False >> ccleaner.ini
echo   (App)Remote Desktop=False >> ccleaner.ini
(echo  AnalyzerTypes=) >> ccleaner.ini
(echo  SystemAnalyzerDrives=C:\) >> ccleaner.ini
(echo  FinderInclude1=) >> ccleaner.ini
(echo  FinderIncludeStates=1) >> ccleaner.ini
(echo  UpdateCheck=0) >> ccleaner.ini
(echo  Monitoring=0) >> ccleaner.ini
(echo  SystemMonitoring=0) >> ccleaner.ini
(echo  DelayRB=1) >> ccleaner.ini
(echo  HideWarnings=1) >> ccleaner.ini
(echo  AutoClose=1) >> ccleaner.ini
(echo  BackupPrompt=0) >> ccleaner.ini
REM MONTHLY MAINTENANCE - 01TH AND 16TH OF MONTH at 10:00PM
1>nul 2>nul schtasks /delete /tn WinBOLT-Monthly-Maintenance /f
1>nul 2>nul SCHTASKS /Create /SC MONTHLY /D 01;16 /st 22:00 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\repo\monthly.vbs" /RU "system" /RL HIGHEST /f

cd C:\Program Files\CCleaner\
ccleaner.exe /clean

cls
echo.
echo.
echo.
echo    ###############################################################
echo    -Running DEEP EmsiSoft EEK scan, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Emsisoft_Scan.log"

sfc /scannow
echo y|chkdsk /f /r C:
defrag c: /h /x
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600

cls
echo.
echo COMPLETED - System will reboot in 10mins to complete maintenance.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto CancelReboot
goto menu

:CancelReboot
cls
shutdown /a
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto menu

:6yes
echo.
echo      Solid State Drive Detected - Skipping Defrag
echo.
echo       Running EVERYTHING, please be patient this will take a few hours!
echo.
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
echo.
choco update -y
choco update all -y
choco install ccleaner -y
cd     C:\Program Files\CCleaner\
(echo  [Options]) > ccleaner.ini
(echo  UpdateKey=01/19/2015 01:14:08 PM) >> ccleaner.ini
(echo  WipeFreeSpaceDrives=C:\) >> ccleaner.ini
(echo  CookiesToSave=) >> ccleaner.ini
(echo  RunICS=0) >> ccleaner.ini
(echo  CheckTrialOffer=0) >> ccleaner.ini
echo   (App)Cookies=False >> ccleaner.ini
echo   (App)Recently Typed URLs=False >> ccleaner.ini
echo   (App)Chkdsk File Fragments=False >> ccleaner.ini
echo   (App)Windows Error Reporting=True >> ccleaner.ini
echo   (App)Windows Log Files=True >> ccleaner.ini
echo   (App)DNS Cache=True >> ccleaner.ini
echo   (App)Font Cache=True >> ccleaner.ini
echo   (App)Start Menu Shortcuts=False >> ccleaner.ini
echo   (App)Windows Event Logs=False >> ccleaner.ini
echo   (App)Old Prefetch data=True >> ccleaner.ini
echo   (App)Tray Notifications Cache=False >> ccleaner.ini
echo   (App)Mozilla - Cookies=False >> ccleaner.ini
echo   (App)Mozilla - Internet History=False >> ccleaner.ini
echo   (App)Google Chrome - Cookies=False >> ccleaner.ini
echo   (App)Google Chrome - Internet History=False >> ccleaner.ini
echo   (App)Adobe Acrobat XI=False >> ccleaner.ini
echo   (App)Evernote=False >> ccleaner.ini
echo   (App)MS Office Picture Manager=True >> ccleaner.ini
echo   (App)Virtual Clone Drive=True >> ccleaner.ini
echo   (App)FileZilla=False >> ccleaner.ini
echo   (App)LogMeIn=False >> ccleaner.ini
echo   (App)Skype=False >> ccleaner.ini
echo   (App)uTorrent=False >> ccleaner.ini
echo   (App)Sublime Text=False >> ccleaner.ini
echo   (App)TeamViewer=False >> ccleaner.ini
echo   (App)Windows Defender=False >> ccleaner.ini
echo   (App)WinRAR=False >> ccleaner.ini
echo   (App)Remote Desktop=False >> ccleaner.ini
(echo  AnalyzerTypes=) >> ccleaner.ini
(echo  SystemAnalyzerDrives=C:\) >> ccleaner.ini
(echo  FinderInclude1=) >> ccleaner.ini
(echo  FinderIncludeStates=1) >> ccleaner.ini
(echo  UpdateCheck=0) >> ccleaner.ini
(echo  Monitoring=0) >> ccleaner.ini
(echo  SystemMonitoring=0) >> ccleaner.ini
(echo  DelayRB=1) >> ccleaner.ini
(echo  HideWarnings=1) >> ccleaner.ini
(echo  AutoClose=1) >> ccleaner.ini
(echo  BackupPrompt=0) >> ccleaner.ini
REM MONTHLY MAINTENANCE - 01TH AND 16TH OF MONTH at 10:00PM
1>nul 2>nul schtasks /delete /tn WinBOLT-Monthly-Maintenance /f
1>nul 2>nul SCHTASKS /Create /SC MONTHLY /D 01;16 /st 22:00 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\repo\monthly.vbs" /RU "system" /RL HIGHEST /f

cd C:\Program Files\CCleaner\
ccleaner.exe /clean

cls
echo.
echo.
echo.
echo    ###############################################################
echo    -Running DEEP EmsiSoft EEK scan, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Emsisoft_Scan.log"


sfc /scannow
echo y|chkdsk /f /r C:
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600

cls
echo.
echo COMPLETED - System will reboot in 10mins to complete maintenance.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto CancelReboot
goto menu

:CancelReboot
cls
shutdown /a
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto altmenu

:7
cls
mode con:cols=100 lines=55
echo.
echo     ####################################
echo     -WinBOLT v%Current_Version% - Custom Applications-
echo     ####################################
echo.
echo       1)  install PCDecrapifierPortable
echo       2)  install CCleaner
echo       3)  install Malwarebytes
echo       4)  install AdwCleaner
echo       5)  install Enhanced Mitigation Experience Toolkit
echo       6)  install keepass
echo       7)  install Nmap
echo       8)  install Junkware Removal Tool
echo       9)  install Angry IP Scanner
echo      10)  install Ditto
echo      11)  install ComboFix
echo      12)  install GreenShot
echo      13)  install Atom Text Editor
echo      14)  install f.lux
echo      15)  install RKill Portable
echo      16)  install Google Chrome
echo      17)  install Revo Uninstaller
echo      18)  install Mozilla Firefox
echo      19)  install ClamWin 
echo      20)  install Notepad++
echo      21)  install Skype
echo      22)  install FileZilla
echo      23)  install PuTTY
echo      24)  install Dropbox
echo      25)  install VirtualBox
echo      26)  install Sublime Text 3
echo      27)  install TeamViewer
echo      28)  install KeePass
echo      29)  install Cygwin
echo      30)  install Wireshark
echo      31)  install WinRAR
echo      32)  install iTunes
echo      33)  install Classic Shell
echo      34)  install Tor Browser Bundle
echo      35)  install Remote Desktop Connection Manager
echo      36)  install TeraCopy
echo      37)  install TrueCrypt
echo      38)  install GitHub on Windows
echo      39)  install VMware Player
echo      40)  install HexChat
echo.
echo       X)  Back to main menu
echo       S)  Shows installed appliactions
echo.
echo    To UNinstall appliactions enter "U" before the number - (example: U1)
echo.
set /p op=I Select Number #
if %op%==1   goto #1
if %op%==U1  goto U#1
if %op%==2   goto #2
if %op%==U2  goto U#2
if %op%==3   goto #3
if %op%==U3  goto U#3
if %op%==4   goto #4
if %op%==U4  goto U#4
if %op%==5   goto #5
if %op%==U5   goto U#5
if %op%==6   goto #6
if %op%==U6   goto U#6
if %op%==7   goto #7
if %op%==U7   goto U#7
if %op%==8   goto #8
if %op%==U8   goto U#8
if %op%==9   goto #9
if %op%==U9   goto U#9
if %op%==10  goto #10
if %op%==U10  goto U#10
if %op%==11  goto #11
if %op%==U11  goto U#11
if %op%==12  goto #12
if %op%==U12  goto U#12
if %op%==13  goto #13
if %op%==U13  goto U#13
if %op%==14  goto #14
if %op%==U14  goto U#14
if %op%==15  goto #15
if %op%==U15  goto U#15
if %op%==16  goto #16
if %op%==U16  goto U#16
if %op%==17  goto #17
if %op%==U17  goto U#17
if %op%==18  goto #18
if %op%==U18  goto U#18
if %op%==19  goto #19
if %op%==U19  goto U#19
if %op%==20  goto #20
if %op%==U20  goto U#20
if %op%==21  goto #21
if %op%==U21  goto U#21
if %op%==22  goto #22
if %op%==U22  goto U#22
if %op%==23  goto #23
if %op%==U23  goto U#23
if %op%==24  goto #24
if %op%==U24  goto U#24
if %op%==25  goto #25
if %op%==U25  goto U#25
if %op%==26  goto #26
if %op%==U26  goto U#26
if %op%==27  goto #27
if %op%==U27  goto U#27
if %op%==28  goto #28
if %op%==U28  goto U#28
if %op%==29  goto #29
if %op%==U29  goto U#29
if %op%==30  goto #30
if %op%==U30  goto U#30
if %op%==31  goto #31
if %op%==U31  goto U#31
if %op%==32  goto #32
if %op%==U32  goto U#32
if %op%==33  goto #33
if %op%==U33  goto U#33
if %op%==34  goto #34
if %op%==U34  goto U#34
if %op%==35  goto #35
if %op%==U35  goto U#35
if %op%==36  goto #36
if %op%==U36  goto U#36
if %op%==37  goto #37
if %op%==U37  goto U#37
if %op%==38  goto #38
if %op%==U38  goto U#38
if %op%==39  goto #39
if %op%==U39  goto U#39
if %op%==40  goto #40
if %op%==U40  goto U#40
if %op%==41  goto #41
if %op%==U41  goto U#41
if %op%==42  goto #42
if %op%==U42  goto U#42
if %op%==43  goto #43
if %op%==43  goto U#43
if %op%==44  goto #44
if %op%==U44  goto U#44
if %op%==45  goto #45
if %op%==U45  goto U#45
if %op%==46  goto #46
if %op%==U46  goto U#46
if %op%==47  goto #47
if %op%==U47  goto U#47
if %op%==48  goto #48
if %op%==U48  goto U#48
if %op%==49  goto #49
if %op%==U49  goto U#49
if %op%==50  goto #50
if %op%==U50  goto U#50
if %op%==51  goto #51
if %op%==U51  goto U#51
if %op%==X goto menu
if %op%==x goto menu
if %op%==quit goto menu
if %op%==Q goto menu
if %op%==q goto menu
if %op%==S goto show
if %op%==s goto show
goto menu

REM INSTALL CUSTOM APPLICATIONS
:#1
1>nul 2>nul choco install pcdecrapifierportable -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#2
1>nul 2>nul choco install ccleaner -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#3
1>nul 2>nul choco install malwarebytes -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#4
1>nul 2>nul choco install adwcleaner -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#5
1>nul 2>nul choco install emet -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#6
1>nul 2>nul choco install keepass -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#7
1>nul 2>nul choco install nmap -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#8
1>nul 2>nul choco install jrt -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#9
1>nul 2>nul choco install angryip -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#10
1>nul 2>nul choco install ditto -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#11
1>nul 2>nul choco install combofix -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#12
1>nul 2>nul choco install greenshot -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#13
1>nul 2>nul choco install atom -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#14
1>nul 2>nul choco install f.lux -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#15
1>nul 2>nul choco install rkillportable -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#16
1>nul 2>nul choco install googlechrome -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#17
1>nul 2>nul choco install revo.uninstaller -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#18
1>nul 2>nul choco install firefox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#19
1>nul 2>nul choco install clamwin -yWhat h
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#20
1>nul 2>nul choco install notepadplusplus -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#21
1>nul 2>nul choco install skype -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#22
1>nul 2>nul choco install filezilla -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#23
1>nul 2>nul choco install putty -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#24
1>nul 2>nul choco install dropbox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#25
1>nul 2>nul choco install virtualbox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#26
1>nul 2>nul choco install sublimetext3 -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#27
1>nul 2>nul choco install teamviewer -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#28
1>nul 2>nul choco install keepass -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#29
1>nul 2>nul choco install cygwin -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#30
1>nul 2>nul choco install wireshark -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#31
1>nul 2>nul choco install winrar -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#32
1>nul 2>nul choco install itunes -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#33
1>nul 2>nul choco install classic-shell -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#34
1>nul 2>nul choco install tor-browser -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#35
1>nul 2>nul choco install rdcman -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#36
1>nul 2>nul choco install teracopy -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#37
1>nul 2>nul choco install truecrypt -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#38
1>nul 2>nul choco install githubforwindows -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#39
1>nul 2>nul choco install vmwareplayer -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#40
1>nul 2>nul choco install hexchat -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#41
1>nul 2>nul choco install **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#42
1>nul 2>nul choco install **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#43
1>nul 2>nul choco install **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#44
1>nul 2>nul choco install **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:#45
1>nul 2>nul choco install **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

REM UNINSTALL CUSTOM APPLICATIONS
:U#1
1>nul 2>nul choco uninstall pcdecrapifierportable -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#2
1>nul 2>nul choco uninstall ccleaner -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#3
1>nul 2>nul choco uninstall malwarebytes -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#4
1>nul 2>nul choco uninstall adwcleaner -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#5
1>nul 2>nul choco uninstall emet -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#6
1>nul 2>nul choco uninstall keepass -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#7
1>nul 2>nul choco uninstall nmap -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#8
1>nul 2>nul choco uninstall jrt -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#9
1>nul 2>nul choco uninstall angryip -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#10
1>nul 2>nul choco uninstall ditto -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#11
1>nul 2>nul choco uninstall combofix -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#12
1>nul 2>nul choco uninstall greenshot -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#13
1>nul 2>nul choco uninstsall atom -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#14
1>nul 2>nul choco uninstall f.lux -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

:U#15
1>nul 2>nul choco uninstall rkillportable -y
cls
echo COMPLETED - Uninstall
timeout /t 2 >nul
goto 7

#############


:U#16
1>nul 2>nul choco uninstall googlechrome -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#17
1>nul 2>nul choco uninstall revo.uninstaller -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#18
1>nul 2>nul choco uninstall firefox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#19
1>nul 2>nul choco uninstall clamwin -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#20
1>nul 2>nul choco uninstall notepadplusplus -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#21
1>nul 2>nul choco uninstall skype -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#22
1>nul 2>nul choco uninstall filezilla -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#23
1>nul 2>nul choco uninstall putty -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#24
1>nul 2>nul choco uninstall dropbox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#25
1>nul 2>nul choco uninstall virtualbox -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#26
1>nul 2>nul choco uninstall sublimetext3 -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#27
1>nul 2>nul choco uninstall teamviewer -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#28
1>nul 2>nul choco uninstall keepass -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#29
1>nul 2>nul choco uninstall cygwin -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#30
1>nul 2>nul choco uninstall wireshark -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#31
1>nul 2>nul choco uninstall winrar -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#32
1>nul 2>nul choco uninstall itunes -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#33
1>nul 2>nul choco uninstall classic-shell -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#34
1>nul 2>nul choco uninstall tor-browser -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#35
1>nul 2>nul choco uninstall rdcman -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#36
1>nul 2>nul choco uninstall teracopy -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#37
1>nul 2>nul choco uninstall truecrypt -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#38
1>nul 2>nul choco uninstall githubforwindows -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#39
1>nul 2>nul choco uninstall vmwareplayer -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#40
1>nul 2>nul choco uninstall hexchat -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#41
1>nul 2>nul choco uninstall **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#42
1>nul 2>nul choco uninstall **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#43
1>nul 2>nul choco uninstall **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#44
1>nul 2>nul choco uninstall **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:U#45
1>nul 2>nul choco uninstall **** -y
cls
echo COMPLETED
timeout /t 2 >nul
goto 7

:show
choco list -localonly
pause
goto 7


:rename
cls

cd C:\WinBOLT\repo\
Set /P op=Provide the new desired Computer name:
IF  "%op%"==""GOTO Error
rename.vbs %op%

cls
echo COMPLETED - Computer Host Name Changed To: %op%
timeout /t 5 >nul
goto menu


:8
cls

pushd "C:\WinBOLT\repo"
start hwinfo.bat
echo.
echo.
echo    ########################################
echo    # WinBOLT v%Current_Version% - WinBOLT System Info - #
echo    ########################################
echo.
echo.
echo Please wait, your system info will display shortly.
echo.
echo.
echo.
echo.
timeout /t 6 >nul


set /p op=Go back to menu? (Y or N)
if %op%==Y  goto menu
if %op%==Y goto menu
if %op%==Yes goto menu
if %op%==yes goto menu
if %op%==y goto menu
goto exit


:backup
REM local backup script
cls
pushd "C:\WinBOLT\repo"
Cscript.exe C:\WinBOLT\repo\wink.vbs
echo.
echo    ###############################################################
echo    # WinBOLT v%Current_Version% - Backup Local Machine - GitHub.com/OnlineLabs #
echo    ###############################################################
echo.
echo Windows XP Not Supported
echo.
echo                    Example:   F:\USBdrive\BackupFolder\
echo.
echo.
echo.
set /p dest=Type Backup Directory: 
IF EXIST %dest% (
      goto scriptv
  ) ELSE (
      goto error01
)

:error01
REM Output if directory is invalid.
cls
color 5
echo Directory invalid or inaccessible, please navigate to verify path accessibility and try again.
timeout /t 3 >nul
goto 10

:scriptv
REM Output if directory is valid.
REM script verifys if you have Windows XP or NEW versions.
color a
IF EXIST "%USERPROFILE%\Documents\" (
        goto backupscriptraw
  ) ELSE (
        goto nosupported
)

:nosupported
REM error page of not supported XP Machine
cls
echo.
echo Windows XP not supported.
echo.
set /p op=Go back to menu? (Y or N)
if %op%==Y  goto menu
if %op%==Y goto menu
if %op%==Yes goto menu
if %op%==yes goto menu
if %op%==y goto menu
goto exit

:backupscriptraw
REM RAW DATA BACKUP OPTION FOR NEW
cls

SET "source01="%USERPROFILE%\Documents"\*.*"
SET "source02="%USERPROFILE%\Contacts"\*.*"
SET "source03="%USERPROFILE%\Desktop"\*.*"
SET "source04="%USERPROFILE%\Downloads"\*.*"
SET "source05="%USERPROFILE%\Favorites"\*.*"
SET "source06="%USERPROFILE%\Links"\*.*"
SET "source07="%USERPROFILE%\Music"\*.*"
SET "source08="%USERPROFILE%\Pictures"\*.*"
SET "source09="%USERPROFILE%\Videos"\*.*"
SET "source09="%USERPROFILE%\AppData"\*.*"
SET profile=%userdomain%_%computername%_%username%
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)

1>nul 2>nul md %dest%\Documents\
1>nul 2>nul md %dest%\Contacts\
1>nul 2>nul md %dest%\Downloads\
1>nul 2>nul md %dest%Favorites\
1>nul 2>nul md %dest%\Links\
1>nul 2>nul md %dest%\Music\
1>nul 2>nul md %dest%\Pictures\
1>nul 2>nul md %dest%\Videos\
1>nul 2>nul md %dest%\AppData\

echo .
echo ---
echo -------[Source Files]-
echo ---
echo .
echo %source01%
echo %source02%
echo %source03%
echo %source04%
echo %source05%
echo %source06%
echo %source07%
echo %source08%
echo %source09%
echo .
echo ---
echo --------[Destination]-[%dest%]-
echo ---
echo .
echo [Please wait.]
echo [Data transferring in the background. You will be alerted once finished.]
1>nul 2>nul timeout /t 5
 
echo Y|xcopy /Q /J /Y /Z "%source01%" "%dest%\Documents\" > %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source02%" "%dest%\Contacts\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source03%" "%dest%\Downloads\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source04%" "%dest%Favorites\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source05%" "%dest%\Links\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source06%" "%dest%\Music\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source07%" "%dest%\Pictures\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source08%" "%dest%\Videos\" >> %dest%\%profile%.log
echo Y|xcopy /Q /J /Y /Z "%source09%" "%dest%\AppData\" >> %dest%\%profile%.log

echo. ##########################################################>> %dest%\%profile%.log
echo. ##########################################################>> %dest%\%profile%.log
echo. |time |find "current" >> %dest%\%profile%.log
echo. |date |find "current" >> %dest%\%profile%.log
echo %profile%>> %dest%\%profile%.log
echo. ##########################################################>> %dest%\%profile%.log

copy "%dest%\%profile%.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_%profile%_Backup.log"

goto backupfinished

:backupfinished
REM Closing menu for finished backup
cls
echo.
echo    ##########################################################
echo    # Local Backup Completed - Please Check Logs for Details #
echo    ##########################################################
echo.
echo  Windows Key Location: C:\WinBOLT\Backups\Logs\
echo  Backup Location: %dest%
echo.
REM pop up script when finished
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "WinBOLT has finished backing up your data." ,10 ,"WinBOLT Backup", 0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
if %errorlevel%==1 (
  echo WinBOLT Backup is completed, you will now return to the main menu.
) else (
  echo WinBOLT Backup is completed, you will now return to the main menu.
)
del %tmp%\tmp.vbs
timeout /t 10 >nul
goto altmenu


:altmenu
REM Alternative Menu to alert users backups have been completed.
cd C:\WinBOLT\repo\
color 8A
echo.
echo    ######################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - GitHub.com/OnlineLabs #
echo    ######################################################################
echo    (Last Updated: %Last_Updated%)
echo.
echo     1)  Install Chocolatey
echo     2)  Run Windows Update and Chocolatey Updates
echo     3)  Enable Maintenance Script (Runs Monthly Each 30th/15th)
echo     4)  Delete Temp, Run CCleaner, EEK update/scan/virus removal.
echo     5)  Defrag HDD, Sys File CHK, File Sys CHK (Auto reboot once completed)
echo     6) *All Of The Above - Full Blown System Maintenance
echo.
echo.    N)  Second Menu
echo     X)  Exit
echo.
echo.    N)  Second Menu
echo     X)  Exit
echo.
echo.
set /p op=I Select Number #
if %op%==1  goto 1
if %op%==2  goto 2
if %op%==3  goto 3
if %op%==4  goto 4
if %op%==5  goto 5
if %op%==6  goto 6
if %op%==n  goto menu2
if %op%==N  goto menu2
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, please try again.
timeout /t 1 >nul
goto menu

:key
pushd "C:\WinBOLT\repo\"
color a
cls


echo.
echo    #######################################################################
echo    # WinBOLT v%Current_Version% - Windows Serial Key Extractor - GitHub.com/OnlineLabs #
echo    #######################################################################
echo.
echo.
echo.
echo Windows Serial Key Output:
echo.
echo     C:\WinBOLT\Backups\Logs\windows_serial_key_backup.log
echo.
echo.
echo.
echo.
Cscript.exe C:\WinBOLT\repo\winkpop.vbs
set /p op=Go back to menu? (Y or N)
if %op%==Y  goto menu
if %op%==Y goto menu
if %op%==Yes goto menu
if %op%==yes goto menu
if %op%==y goto menu
goto exit



:spool
cls
del %systemroot%\System32\spool\printers\* /Q /F /S
echo Printer Spool Clear - COMPLETED
timeout /t 2 >nul
cls
goto menu3

:vipre
REM Vipre Scanner
cls
echo.
echo.
echo.
echo    ###################################################
echo    -Running Vipre Scan, cancel anytime with (Ctr + C)-
echo    ###################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\Vipre\"
VipreRescueScanner.exe /nolog >> "C:\WinBOLT\Vipre\Live_Vipre_Scan.log"
copy "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Vipre_Scan.log"

:sophos
REM Sophos Scanner
echo      ###############################################
echo      -Running Sophos, cancel anytime with (Ctr + C)-
echo      ###############################################
echo.
echo.
del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" >nul 2>&1
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Sophos\"
svrtcli.exe -yes -debug
copy "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Sophos_Scan.log"



:intel
cls
color a
echo.
echo.
echo                Intel On                              .//+/-..:s     
echo                   WinBOLT                         `:/+:`       y`    
echo                       v%Current_Version%                    ./+/.`            h`    
echo                                             `/+/`    `        `h     
echo                                            :+/.   .ossoss:     +:     
echo                                        `/+-`    .d:`   .h+   `y      
echo                             `.--::::--+/.       oy      :m   s.      
echo                      `-://+/::-..../s/`         -m-    `yo  /+       
echo                   .:+/-.`        .+/`         `` -ss++os/  -s        
echo                 .o/.`          `+/`        `/+/o:  `...   .y`        
echo                 -o/:--.       -o.        `/o-  /+        .y`         
echo                   `.--:+/:-` /+`        -o:   :s`       .s.          
echo                         `.:/os        `++`  `++`       .s.           
echo                             `+/`     :o.   -o-        -s`            
echo                               -s:` `o/   .+/`        /d`             
echo                             `:+/:s/s-  `++.        `o//+             
echo                            :o-  /+h. `/o.         -o.  d             
echo                           /o   +/y``:oy.`       .+/    d             
echo                           h`  .oh-/o/+.:y/.`  .++`     h`            
echo                           h`  .oos+:-  :o`:/+o/.       h`            
echo                           o:   `.`    -y`   `o+        d             
echo                           s-   ````./+/       :s`     .y             
echo                          +o`-+/////-`          .y.    s:             
echo                         `d++-                   `y`  -y              
FOR /L %%n IN (1,1,10) DO ping -n 1 127.0.0.1 > nul & <nul set /p =.
timeout /t 5 >nul

cls
color cf
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ****************** ( - WinBOLT Creator - ) ***********************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo License: GNU GENERAL PUBLIC LICENSE
echo Created by Christian Vazquez
echo Email:Christian_V@live.com 
echo Github.com/OnlineLabs
echo Created 12/13/14
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ************** ( - Current Version and Info - ) ******************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Current Version: %Current_Version%
echo.
echo This tool is created by a Technician for the Technicians.
echo This will simplify your job on the Windows Operating System.
echo Working with these systems, more often than not tasks like maintenance becomes perpetual.
echo.
echo With that in mind, my ultimate goal and function of WinBOLT was simple..
echo Provide and deliever fool proof automation.
echo.
echo This tool is simple, effective and powerful.
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo Thanks To: @Roman @Devon @Alextrasza @Aura
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
FOR /L %%n IN (1,1,10) DO ping -n 2 127.0.0.1 > nul & <nul set /p =.
echo.
pause
goto menu2

:exit
cls

color 7
echo.
echo.
echo.
echo           WinBOLT has been closed, may the force be with you!
echo.
echo.
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
color a
timeout /t 1 >nul
color c
timeout /t 1 >nul
:random
color a
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
echo %random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%%random%
exit
