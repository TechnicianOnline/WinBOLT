@echo off
mode con:cols=90 lines=30
REM ###################################################################################################################
REM ######################################### ( - WinBOLT Creator - ) #################################################
REM ###################################################################################################################
REM License: GNU GENERAL PUBLIC LICENSE
REM Created by Christian Vazquez
REM Email:Christian_V@live.com
REM SourceForge.net/p/winbolt
REM Created 12/13/14
REM ###################################################################################################################
REM ####################################### ( - Current Version and Info - ) ##########################################
REM ###################################################################################################################
SET LAST_UPDATED=11.04.2015
SET Current_Version=3.2
SET wsize=10096
REM ###################################################################################################################
REM ######################################## ( - Change Log and Version - ) ###########################################
REM ###################################################################################################################
REM **v.02: Added Registry Entry to disable UAC.
REM **v.02: Added ccleaner monthly autoscheduler with customer config .INI file (Does NOT delete cookies).
REM **v.02: Added "Maintenance Script Autoschedule to Menu" runs every 16th of the month at 10pm.
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
REM **v3.0: added sophos scanner
REM **v3.0: added malwarebytes antimalware scanner
REM **v3.0: removed github repo, now use sourceforge for distribution
REM **v3.1: added reboot switchs and mix options
REM **v3.1: added rkill to option #4, #6 and #9
REM **v3.1: split WinBOLT core and addon package
REM **v3.1: added cryptoprevent
REM **v3.2: refined code
REM ###################################################################################################################
REM ###################################################################################################################

color e
title (- WinBOLTv%Current_Version% - www.SourceForge.net/p/winbolt -)

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
1>nul 2>nul setx path "%path%;C:\WinBOLT\"
cls

:Verification
REM DEFINES WINDOWS EDITION FOR UAC REQUIREMENT



REM Covers Windows 10 editions and Windows Server 2016 editions.
1>nul 2>nul ver | findstr "10.0"
if %ERRORLEVEL% == 0 goto power

REM Covers WIndows 8.1 editions and Windows Server 2012 editions.
1>nul 2>nul ver | findstr "6.3"
if %ERRORLEVEL% == 0 goto power

REM Covers Windows 8 editions and Windows Server 2012 editions.
1>nul 2>nul ver | findstr "6.2"
if %ERRORLEVEL% == 0 goto power

REM Covers Windows 7 editions and Windows Server 2008 R2 editions.
1>nul 2>nul ver | findstr "6.1"
if %ERRORLEVEL% == 0 goto uac

REM Covers Windows Vista editions and Windows Server 2008 editions.
1>nul 2>nul ver | findstr "6.0"
if %ERRORLEVEL% == 0 goto uac

REM Covers Windows XP 64Bit editions and Windows Server 2003, 2003 R2.
1>nul 2>nul ver | findstr "5.2"
if %ERRORLEVEL% == 0 goto uac

REM Covers Windows XP 32/86bit editions
1>nul 2>nul ver | findstr "5.1"
if %ERRORLEVEL% == 0 goto uac

REM Covers Windows 2000 editions.
1>nul 2>nul ver | findstr "5.0"
if %ERRORLEVEL% == 0 goto uac

:uac
REM This will disable UAC. It's required for WinBOLT but not needed on Windows 8 and above.
1>nul 2>nul REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
1>nul 2>nul REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0x0 /f

:power
REM This will disable all sleep/hibernation/monitor timeout counters.
1>nul 2>nul powercfg -change -monitor-timeout-ac 0
1>nul 2>nul powercfg -change -standby-timeout-ac 0
1>nul 2>nul powercfg -change -disk-timeout-ac 0
1>nul 2>nul powercfg -change -hibernate-timeout-ac 0

:package
REM Core and Addon Package Check
IF EXIST C:\WinBOLT\Sophos IF Exist C:\WinBOLT\Vipre (
    cls
    echo.
    echo                    WinBOLT Addon Package Detected. Enjoy!
    echo.
    echo.
    echo.
    timeout /t 2 >nul
) ELSE (
    cls
    echo.
    echo                    WinBOLT Core Package Detected.
    echo.
    echo.
    echo.
    timeout /t 2 >nul
)

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
echo                         `d++-                   `y` -y
FOR /L %%n IN (1,1,10) DO ping 1 127.0.0.1 > nul & <nul set /p =.
timeout /t 2 >nul

:ToS
REM Terms as Stated
cls
color CF
echo.
echo      ####################################################
echo      #  Read, Agree and Accept - Terms as Stated (TaS)  #
echo      ####################################################
echo.
echo           WinBOLT v%Current_Version%
echo           Copyright (C) 2014  Christian Vazquez
echo.
echo               This program is distributed in the hope that it will be useful,
echo               but WITHOUT ANY WARRANTY; without even the implied warranty of
echo               MERCHANTABILITY or A PARTICULAR PURPOSE.  See the
echo               GNU General Public License for more details.
echo.
ECHO      User Understands:
echo           [X] You're the owner or explicit authorized administrator.
echo           [X] This product is licened under GNU General Public v2.
echo.
echo      System Requirements:
echo           [X] .NET Framework version 3.5 and above is required.
echo           [X] PowerShell version 2.0 and above is required.
echo.
echo.
echo.
echo.
set /p op=Do you agree to the terms and conditions as stated? (Yes or No):
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
    EXIT /B 3
)

REM GREETING MENU
:menu
mode con:cols=90 lines=30
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ##########################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - SourceForge.net/p/winbolt #
echo    ##########################################################################
echo                                            (Last Updated: %Last_Updated%)
echo.
echo.
echo.
echo.
echo     1)  Install Chocolatey
echo     2)  Run Windows Update and Chocolatey Updates
echo     3)  Enable Maintenance Script (Runs Monthly Each 16th @ 10PM)
echo     4)  Rkill, TDSS, Delete Temp, CCleaner, EEK Scan, CryptoPrevent.
echo     5)  Defrag HDD, Sys File CHK, File Sys CHK (Auto reboot once completed)
echo     6) *All Of The Above - Full Blown System Maintenance
echo.
echo.
echo     Reboot now supported, just add "r" to your selection.
echo     Example: 1r   or   2r   or   24r
echo.
echo.
echo.    N)  Second Menu
echo     X)  Exit
echo.
echo.
echo.
set /p op=I Select Number #
if %op%==1  goto 1
if %op%==2  goto 2
if %op%==2r goto 2r
if %op%==3  goto 3
if %op%==4  goto 4
if %op%==4r goto 4r
if %op%==5  goto 5
if %op%==5r goto 5
if %op%==6  goto 6
if %op%==6r goto 6
if %op%==24r goto 24r
if %op%==124r goto 124r
if %op%==n  goto menu2
if %op%==N  goto menu2
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
if %op%==l2d goto l2d
if %op%==L2D goto l2d
echo Incorrect input, please try again.
timeout /t 1 >nul
goto menu


:menu2
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ##########################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - SourceForge.net/p/winbolt #
echo    ##########################################################################
echo                                            (Last Updated: %Last_Updated%)
echo.
echo                        Second Menu - Misc Options
echo.
echo.
echo.
echo     7)  Install Custom Applications
echo     8)  Get Hardware Information
echo     9)  Special Tools and Actions
echo.
echo.
echo.
echo.
echo     i)  Information on WinBOLT
echo     R)  Return to the first menu
echo     X)  Exit WinBOLT
echo.
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
REM Core and Addon Package Check
IF EXIST C:\WinBOLT\Vipre IF EXIST C:\WinBOLT\Sophos goto adpackage
cls
echo.
echo     WinBOLT Core Detected.
echo     Download Addon Package ^for full functionality.
echo.
echo.
echo.
echo.
set /p op=Download WinBOLT Addon Package? (Yes or No):
if %op%==Y goto download
if %op%==Yes goto download
if %op%==yes goto download
if %op%==y goto download
goto corepackage


:download
cls
echo.
echo.
echo  Downloading your file, please wait.
echo.
echo.
start http://sourceforge.net/projects/winbolt/files/Addon_Package/WinBOLT_v3.1_Addon.exe/download
echo.
pause
exit


:adpackage
cls
color a
echo. WinBOLT Addon Package Detected.
timeout /t 2 >nul
cd C:\WinBOLT\repo\
cls

echo.
echo    ##########################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - SourceForge.net/p/winbolt #
echo    ##########################################################################
echo                                            (Last Updated: %Last_Updated%)
echo.
echo                        Special Tools and Actions - Menu
echo.
echo         10)  Rename Computer Host Name
echo         11)  Backup Local User Files (XP Not Supported)
echo         12)  Extract Windows Serial Key
echo         13)  Fix Printing Issues - Clear System Spools
echo         14)  Rkill - Stops Active Malware Programs
echo         15)  Full System Scan - Kaspersky TDRSSKiller
echo         16)  Full System Scan - Sophos
echo         17)  Full System Scan - VIPRE
echo         18)  Full System Scan - MalwareBytes
echo         19)  Full System Scan - Emsisoft
echo         20)  CryptoPrevent - Apply System Protection
echo.
echo    100) [Thunder Scan] Option: 14, 15, 16, 17, 18, 19, 20.
echo.
echo.
echo     i)  Information on WinBOLT
echo     R)  Return to the second menu
echo     X)  Exit WinBOLT
echo.
echo.
set /p op=I Select Number #
if %op%==7  goto 7
if %op%==8  goto 8
if %op%==10 goto 10
if %op%==11 goto 11
if %op%==12 goto 12
if %op%==13 goto 13
if %op%==14 goto 14
if %op%==15 goto 15
if %op%==16 goto 16
if %op%==17 goto 17
if %op%==18 goto 18
if %op%==19 goto 19
if %op%==20 goto 20
if %op%==100 goto 100
if %op%==i goto intel
if %op%==I goto intel
if %op%==r goto menu2
if %op%==R goto menu2
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, try again.
timeout /t 1 >nul
goto addonpackage


:corepackage
cd C:\WinBOLT\repo\
color a
cls

echo.
echo    ##########################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - SourceForge.net/p/winbolt #
echo    ##########################################################################
echo                                            (Last Updated: %Last_Updated%)
echo.
echo                        Special Tools and Actions - Menu
echo.
echo         10)  Rename Computer Host Name
echo         11)  Backup Local User Files (XP Not Supported)
echo         12)  Extract Windows Serial Key
echo         13)  Fix Printing Issues - Clear System Spools
echo         14)  Rkill - Stops Active Malware Programs
echo         15)  Full System Scan - Kaspersky TDRSSKiller
echo         16)  Full System Scan - Sophos [disabled]
echo         17)  Full System Scan - VIPRE  [disabled]
echo         18)  Full System Scan - MalwareBytes
echo         19)  Full System Scan - Emsisoft
echo         20)  CryptoPrevent - Apply System Protection
echo.
echo    100) [Limited Thunder Scan] Option: 14, 15, 18, 19, 20.
echo.
echo.
echo     i)  Information on WinBOLT
echo     R)  Return to the second menu
echo     X)  Exit WinBOLT
echo.
echo.
echo.
set /p op=I Select Number #
if %op%==7  goto 7
if %op%==8  goto 8
if %op%==10 goto 10
if %op%==11 goto 11
if %op%==12 goto 12
if %op%==13 goto 13
if %op%==14 goto 14
if %op%==15 goto 15
if %op%==18 goto 18
if %op%==19 goto 19
if %op%==20 goto 20
if %op%==100 goto core100
if %op%==100r goto core100r
if %op%==i goto intel
if %op%==I goto intel
if %op%==r goto menu2
if %op%==R goto menu2
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
echo Incorrect input, try again.
timeout /t 1 >nul
goto corepackage


:124r
REM Does Op: 1, 2, 4, reboot.
REM [pending verification] Order in which is runs: 1, 4, 2, reboot.
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
timeout -t 3

cls

echo.
echo.
echo       Running Chocolatey Updates, Please Wait!
echo.
echo.
echo.
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
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
echo Windows Update Output:
echo    C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log
echo.
Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"


cls
echo COMPLETED - Update Windows and Chocolatey Apps
timeout /t 3 >nul

cls
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
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
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Emsisoft_Scan.log"



cls
echo COMPLETED - Windows Tune up!
timeout /t 3 >nul
shutdown -r -t 0 -f



:24r

cls

REM Rkill, TDSSKiller, Chocolatey Install, CCleaner, EEK, CryptoPrevent, then applys updates on choco and windows updates.
REM [VERIFIED] Audited the code: 10/26/2015

echo.
echo    Running RKill, please wait.
REM RKill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\Backups\Logs\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
echo FINISHED.


echo.
echo    Installing Chocolatey, please wait.
REM Checks if chocolatey is installed or not.
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto ICHOCO
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\ichoco.vbs
1>nul 2>nul timeout /t 200
goto ICHOCO
:ICHOCO
echo FINISHED.


echo.
echo    Running Kaspersky TDSSKiller, please wait.
REM TDSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
echo FINISHED.


echo.
echo    Running CCleaner, please wait.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CONTINUE
1>nul 2>nul timeout /t 200

:CONTINUE
1>nul 2>nul choco install ccleaner -y
1>nul 2>nul timeout /t 5
REM CUSTOM CONFIG FOR CCLEANER APP.
1>nul 2>nul cd C:\Program Files\CCleaner\
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
if %OS%==32BIT 1>nul 2>nul ccleaner.exe /auto
if %OS%==32BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner.exe /auto
if %OS%==64BIT 1>nul 2>nul ccleaner64.exe /auto
if %OS%==64BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner64.exe /auto
echo FINISHED.


echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.


echo.
echo    Applying CryptoPrevent, please wait.
REM CryptoPrevent Portable Version
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
echo FINISHED.

echo.
echo    Updating Chocolatey Framework, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_choco_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade chocolatey -y > C:\WinBOLT\Backups\Logs\live_choco_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_choco_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Choco_Update.log"
echo FINISHED.
echo.
echo    Updating Chocolatey installed applications, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade all -y > C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_ChocoApps_Update.log"
echo FINISHED.
echo.
echo    Updating Windows, please wait. This may take hours the first time.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
1>nul 2>nul copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
echo FINISHED.
echo.
echo.
echo Will be rebooting in 30 seconds!
shutdown -r -t 30 -f

:1
REM Checks for Chocolatey then installs if missing.
REM [VERIFIED GOOD] - Audited code 10/5/2015
cls
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CI

REM CNI = chocolatey not installed.
:CNI
cls
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
cls
echo.
echo. Chocolatey installed.
1>nul 2>nul timeout -t 2
goto menu

REM CI = chocolatey installed.
:CI
cls
echo.
echo.
echo Chocolatey is already installed.
echo.
echo.
1>nul 2>nul timeout -t 2
goto menu


:2
REM Runs chocolatey framework update, runs updates on programs installed by chocolatey, runs windows updates.
REM [VERIFIED GOOD] Audited the code: 10/5/2015
cls
echo.
echo.
echo    Updating Chocolatey Framework, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_choco_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade chocolatey -y > C:\WinBOLT\Backups\Logs\live_choco_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_choco_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Choco_Update.log"
echo FINISHED.
echo.
echo.
echo    Updating Chocolatey installed applications, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade all -y > C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_ChocoApps_Update.log"
echo FINISHED.
echo.
echo.
echo    Updating Windows, please wait. This may take hours the first time.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
1>nul 2>nul copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
echo FINISHED.
1>nul 2>nul timeout -t 5
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
pause
goto menu

:2r
REM Runs chocolatey framework update, runs updates on programs installed by chocolatey, runs windows updates, then reboots.
REM [VERIFIED GOOD] Audited the code: 10/5/2015
cls
echo.
echo.
echo    Updating Chocolatey Framework, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_choco_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco update -y > C:\WinBOLT\Backups\Logs\live_choco_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_choco_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Choco_Update.log"
echo FINISHED.
echo.
echo.
echo    Updating Chocolatey installed applications, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco update all -y > C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_ChocoApps_Update.log"
echo FINISHED.
echo.
echo.
echo    Updating Windows, please wait. This may take hours the first time.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
1>nul 2>nul copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
echo FINISHED.
shutdown -r -t 0 -f


:3
REM Runs a scheduled task as the system user, 16'th at 10PM.
REM [VERIFIED GOOD] Audited the code: 10/09/2015
cls

echo.
echo.
echo       Installing Maintenance Script Autoschedule; Please Wait!
echo.
echo.

REM MONTHLY MAINTENANCE - 16TH OF MONTH at 10:00PM
1>nul 2>nul schtasks /delete /tn WinBOLT-Monthly-Maintenance /f
1>nul 2>nul SCHTASKS /Create /SC MONTHLY /D 16 /st 22:00 /TN "WinBOLT-Month-Maintenance" /TR "C:\WinBOLT\repo\xmonth.vbs" /RU "system" /RL HIGHEST /f


cls
echo COMPLETED - Maintenance Script Autoschedule
timeout /t 3 >nul
goto menu



:4
REM Rkill, TDSSKiller, Chocolatey Install, CCleaner, EEK, CryptoPrevent.
REM [VERIFIED] Audited the code: 10/26/2015
cls


echo.
echo    Running RKill, please wait.
REM RKill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\Backups\Logs\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
echo FINISHED.


echo.
echo    Installing Chocolatey, please wait.
REM Checks if chocolatey is installed or not.
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto ICHOCO
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\ichoco.vbs
1>nul 2>nul timeout /t 200
goto ICHOCO
:ICHOCO
echo FINISHED.


echo.
echo    Running Kaspersky TDSSKiller, please wait.
REM TDSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
echo FINISHED.


echo.
echo    Running CCleaner, please wait.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CONTINUE
1>nul 2>nul timeout /t 200

:CONTINUE
1>nul 2>nul choco install ccleaner -y
1>nul 2>nul timeout /t 5
REM CUSTOM CONFIG FOR CCLEANER APP.
1>nul 2>nul cd C:\Program Files\CCleaner\
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
if %OS%==32BIT 1>nul 2>nul ccleaner.exe /auto
if %OS%==32BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner.exe /auto
if %OS%==64BIT 1>nul 2>nul ccleaner64.exe /auto
if %OS%==64BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner64.exe /auto
echo FINISHED.


echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.


echo.
echo    Applying CryptoPrevent, please wait.
REM CryptoPrevent Portable Version
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
echo FINISHED.


echo.
echo Completed your request. You will redirect to the menu.
echo Please check C:\WinBOLT\Backups\Logs for more information.
timeout /t 30 >nul
goto menu


:4r
REM Rkill, TDSSKiller, Chocolatey Install, CCleaner, EEK, CryptoPrevent.
REM [VERIFIED] Audited the code: 10/26/2015
cls


echo.
echo    Running RKill, please wait.
REM RKill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\Backups\Logs\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
echo FINISHED.


echo.
echo    Running Kaspersky TDSSKiller, please wait.
REM TDSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
echo FINISHED.


echo.
echo    Installing Chocolatey, please wait.
REM Checks if chocolatey is installed or not.
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto ICHOCO
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\ichoco.vbs
1>nul 2>nul timeout /t 200
goto ICHOCO
:ICHOCO
echo FINISHED.


echo.
echo    Running CCleaner, please wait.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CONTINUE
1>nul 2>nul timeout /t 200

:CONTINUE
1>nul 2>nul choco install ccleaner -y
1>nul 2>nul timeout /t 5
REM CUSTOM CONFIG FOR CCLEANER APP.
1>nul 2>nul cd C:\Program Files\CCleaner\
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
if %OS%==32BIT 1>nul 2>nul ccleaner.exe /auto
if %OS%==32BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner.exe /auto
if %OS%==64BIT 1>nul 2>nul ccleaner64.exe /auto
if %OS%==64BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner64.exe /auto
echo FINISHED.


echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.


echo.
echo    Applying CryptoPrevent, please wait.
REM CryptoPrevent Portable Version
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
echo FINISHED.


echo.
echo Completed your request. You will redirect to the menu.
echo Please check C:\WinBOLT\Backups\Logs for more information.
timeout /t 30 >nul
shudown -r -t 0 -f


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
shutdown /r /t 600 -f


cls
echo.
echo COMPLETED - System will reboot in 10mins to complete changes to file system.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto CanReboot
goto menu

:CanReboot
shutdown /a
cls
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
mode con:cols=100 lines=55
cls
echo.
echo.
echo     First time running? This may be a few hours.
echo.
echo.
1>nul 2>nul timeout /t 5
echo.
echo.
echo     Not the first time? This shouldn't be more than two hours.
echo     (NOTE: Time is drastically affected if your PC is infected.)
echo.
echo.
1>nul 2>nul timeout /t 5
echo.
echo.
echo     Consider running option "24r" if you're pressed for time.
echo.
echo.
1>nul 2>nul timeout /t 5

REM Start Opt# 1

REM Checks for Chocolatey installation, installs if missing.
cls
echo.
echo    Installing Chocolatey, please wait.
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto ICHOCO
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\ichoco.vbs
1>nul 2>nul timeout /t 200
goto ICHOCO
:ICHOCO
echo FINISHED.

REM End Opt# 1

REM Start Opt# 4.

REM Runs RKill with whitelist.
echo.
echo    Running RKill, please wait.
REM RKill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\Backups\Logs\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
echo FINISHED.

REM Runs Kaspersky TDSSKiller and leaves log file.
echo.
echo    Running Kaspersky TDSSKiller, please wait.
REM TDSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
echo FINISHED.

REM Checks for Chocolatey installation, if missing that means it's not finished installing and will request more time before installing CCleaner.
REM Querys registry for 32/64 bit cpu, then runs the correct version of CCleaner.
echo.
echo    Running CCleaner, please wait.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CONTINUE
1>nul 2>nul timeout /t 300

:CONTINUE
1>nul 2>nul choco install ccleaner -y
1>nul 2>nul timeout /t 5
REM CUSTOM CONFIG FOR CCLEANER APP.
1>nul 2>nul cd C:\Program Files\CCleaner\
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
if %OS%==32BIT 1>nul 2>nul ccleaner.exe /auto
if %OS%==32BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner.exe /auto
if %OS%==64BIT 1>nul 2>nul ccleaner64.exe /auto
if %OS%==64BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner64.exe /auto
echo FINISHED.

REM EEK antimalware scan.
echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.

REM CryptoPrevent rules get applied.
echo.
echo    Applying CryptoPrevent, please wait.
REM CryptoPrevent Portable Version
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
echo FINISHED.

REM Ends Opt# 4.

REM Starts Opt# 2

echo.
echo    Updating Chocolatey Framework, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_choco_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade chocolatey -y > C:\WinBOLT\Backups\Logs\live_choco_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_choco_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Choco_Update.log"
echo FINISHED.
echo.
echo    Updating Chocolatey installed applications, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade all -y > C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_ChocoApps_Update.log"
echo FINISHED.
echo.
echo    Updating Windows, please wait. This may take hours the first time.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
1>nul 2>nul copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
echo FINISHED.

REM Ends Opt# 2.

REM Start Opt# 5
echo.
echo    Running System File Check.
1>nul 2>nul sfc /scannow > C:\WinBOLT\Backups\Logs\live_SysFileCheck.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\backups\logs\live_SysFileCheck.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_SysFileCheck.log"
echo FINISHED.

echo.
echo    Applying disk check on next reboot.
1>nul 2>nul call:Dcheck
echo FINISHED.

echo.
echo    HDD detected, running defragmentation on %systemdrive%
1>nul 2>nul defrag %systemdrive% /h /x > C:\WinBOLT\Backups\Logs\recent_Defrag.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\Backups\logs\recent_Defrag.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Defrag.log"
echo FINISHED.
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600

REM Ends Opt# 5

1>nul 2>nul timeout /t 10
cls
echo.
echo    COMPLETED - System will reboot in 10mins to complete maintenance.
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
mode con:cols=100 lines=55
cls
echo.
echo     Solid State Drive Detected - Skipping defragmentation.
echo.
1>nul 2>nul timeout /t 5
cls
echo.
echo.
echo     First time running? This may be a few hours.
echo.
echo.
1>nul 2>nul timeout /t 5
echo.
echo.
echo     Not the first time? This shouldn't be more than two hours.
echo     (NOTE: Time is drastically affected if your PC is infected.)
echo.
echo.
1>nul 2>nul timeout /t 5
echo.
echo.
echo     Consider running option "24r" if you're pressed for time.
echo.
echo.
1>nul 2>nul timeout /t 5

REM Start Opt# 1

REM Checks for Chocolatey installation, installs if missing.
cls
echo    Installing Chocolatey, please wait.
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto ICHOCO
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\ichoco.vbs
1>nul 2>nul timeout /t 200
goto ICHOCO
:ICHOCO
echo FINISHED.

REM End Opt# 1

REM Start Opt# 4.

REM Runs RKill with whitelist.
echo.
echo    Running RKill, please wait.
REM RKill
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\Backups\Logs\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
echo FINISHED.

REM Runs Kaspersky TDSSKiller and leaves log file.
echo.
echo    Running Kaspersky TDSSKiller, please wait.
REM TDSS Killer
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
echo FINISHED.

REM Checks for Chocolatey installation, if missing that means it's not finished installing and will request more time before installing CCleaner.
REM Querys registry for 32/64 bit cpu, then runs the correct version of CCleaner.
echo.
echo    Running CCleaner, please wait.
reg Query "HKLM\Hardware\Description\System\CentralProcessor\0" | find /i "x86" > NUL && set OS=32BIT || set OS=64BIT
IF EXIST %allusersprofile%\chocolatey\bin\choco.exe goto CONTINUE
1>nul 2>nul timeout /t 300

:CONTINUE
1>nul 2>nul choco install ccleaner -y
1>nul 2>nul timeout /t 5
REM CUSTOM CONFIG FOR CCLEANER APP.
1>nul 2>nul cd C:\Program Files\CCleaner\
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
if %OS%==32BIT 1>nul 2>nul ccleaner.exe /auto
if %OS%==32BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner.exe /auto
if %OS%==64BIT 1>nul 2>nul ccleaner64.exe /auto
if %OS%==64BIT 1>nul 2>nul C:\Program Files\CCleaner\ccleaner64.exe /auto
echo FINISHED.

REM EEK antimalware scan.
echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.

REM CryptoPrevent rules get applied.
echo.
echo    Applying CryptoPrevent, please wait.
REM CryptoPrevent Portable Version
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
echo FINISHED.

REM Ends Opt# 4.

REM Starts Opt# 2

echo.
echo    Updating Chocolatey Framework, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_choco_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade chocolatey -y > C:\WinBOLT\Backups\Logs\live_choco_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_choco_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Choco_Update.log"
echo FINISHED.
echo.
echo    Updating Chocolatey installed applications, please wait.
1>nul 2>nul del /Q /F C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul choco upgrade all -y > C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log
1>nul 2>nul copy "C:\WinBOLT\Backups\Logs\live_ChocoApps_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_ChocoApps_Update.log"
echo FINISHED.
echo.
echo    Updating Windows, please wait. This may take hours the first time.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul Cscript.exe C:\WinBOLT\repo\winups.vbs > C:\WinBOLT\live_windows_update.log
1>nul 2>nul copy "C:\WinBOLT\live_windows_update.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_Windows_Update.log"
echo FINISHED.

REM Ends Opt# 2.

REM Start Opt# 5
echo.
echo    Running System File Check.
1>nul 2>nul sfc /scannow > C:\WinBOLT\Backups\Logs\live_SysFileCheck.log
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\backups\logs\live_SysFileCheck.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_SysFileCheck.log"
echo FINISHED.

echo.
echo    Applying disk check on next reboot.
1>nul 2>nul call:Dcheck
echo FINISHED.

echo.
echo    SSD detected, skipping defragmentation.
echo FINISHED.
REM SHUTDOWN TIME 10MINS
shutdown /r /t 600

REM Ends Opt# 5

cls
echo.
echo COMPLETED - System will reboot in 10mins to complete maintenance.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot.
if %op%==Y  goto KillReboot
if %op%==y  goto KillReboot

goto menu

:KillReboot
cls
shutdown /a
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto menu

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

:9
REM this should NOT be an option, it's a special menue!

:10
cls

cd C:\WinBOLT\repo\
Set /P op=Provide the new desired Computer name:
IF  "%op%"==""GOTO Error
rename.vbs %op%

cls
echo COMPLETED - Computer Host Name Changed To: %op%
timeout /t 5 >nul
goto menu


:11
REM local backup script
cls
pushd "C:\WinBOLT\repo"
Cscript.exe C:\WinBOLT\repo\wink.vbs
echo.
echo    ###################################################################
echo    # WinBOLT v%Current_Version% - Backup Local Machine - SourceForge.net/p/winbolt #
echo    ###################################################################
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
echo    ##########################################################################
echo    # WinBOLT v%Current_Version% - Maintenance Automation Tool - SourceForge.net/p/winbolt #
echo    ##########################################################################
echo    (Last Updated: %Last_Updated%)
echo.
echo     1)  Install Chocolatey
echo     2)  Run Windows Update and Chocolatey Updates
echo     3)  Enable Maintenance Script (Runs Monthly Each 16th @ 10PM)
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

:12
pushd "C:\WinBOLT\repo\"
color a
cls

echo.
echo    ###########################################################################
echo    # WinBOLT v%Current_Version% - Windows Serial Key Extractor - SourceForge.net/p/winbolt #
echo    ###########################################################################
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


:13
cls
del %systemroot%\System32\spool\printers\* /Q /F /S
echo Printer Spool Clear - COMPLETED
timeout /t 2 >nul
cls
goto menu3


:14
REM RKill
cls
echo.
echo.
echo.
echo    ###############################################
echo    -Running   cancel anytime with (Ctr + C)-
echo    ###############################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
cls
goto menu3


:15
REM TDSS Killer
cls
echo.
echo.
echo.
echo    ####################################################
echo    -Running TDSSKiller,  cancel anytime with (Ctr + C)-
echo    ####################################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"

cls
goto menu3


:16
cls
REM Sophos Scanner
echo      ###############################################
echo      -Running Sophos, cancel anytime with (Ctr + C)-
echo      ###############################################
echo.
echo.
del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Sophos\"
svrtcli.exe -yes
copy "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Sophos_Scan.log"
cls
goto menu3


:17
cls
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
del /f /q "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Vipre\"
VipreRescueScanner.exe /nolog >> "C:\WinBOLT\Vipre\Live_Vipre_Scan.log"
copy "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Vipre_Scan.log"
cls
goto menu3


:18
cls
REM MBAM Scanner
cls
color ce
echo.
echo    #######################################################################
echo    -            MalwareBytes Anti-Malware Automation - BETA              -
echo    #######################################################################
echo.
echo.
echo.
echo          MBAM is difficult to automate, therefor if you run into ANY
echo      problems with the BETA method, you will need to run the MBAM Cleanup
echo      Utility, reboot... yes REBOOT, then try again.
echo.
echo.
echo.
echo.
echo.
echo.
echo   Hit any key to continue...
pause 1>nul 2>nul
cls

echo.
echo    #######################################################################
echo    -            MalwareBytes Anti-Malware Automation - BETA              -
echo    #######################################################################
echo.
echo.
echo.
echo         #1) - Run MBAM Automated Scan
echo         #2) - Run MBAM Cleanup Utility
echo         #3) - Return to Special Menu
echo.
echo.
set /p op=I Select Number #:
if %op%==1  goto mbam
if %op%==2  goto mbamcu
if %op%==3  goto menu3

:mbam
cls
echo.
echo [x] MalwareBytes installation services are preparing!
pushd "C:\WinBOLT\repo"
mbam.exe /silent
timeout /t 10 1>nul 2>nul
pushd "c:\users\%username%\desktop\"
del /F Malwarebytes Anti-Malware.lnk 1>nul 2>nul
pushd "C:\Program Files (x86)\Malwarebytes' Anti-Malware"
mbam.exe /register 3YL75 2B5C-AQHH-CQM9-311G
timeout /t 10 1>nul 2>nul
echo.
echo [x] MalwareBytes is installed!
taskkill /F /IM mbam* /T 1>nul 2>nul
Cscript.exe C:\WinBOLT\repo\mbam_update.vbs 1>nul 2>nul
timeout /t 60 1>nul 2>nul
echo.
timeout /t 2 1>nul 2>nul
echo [x] MalwareBytes virus definitions updated!
echo.
echo [x] Scanning with MalwareBytes Anti-Malware please wait...
echo.
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /logtofolder "C:\WinBOLT\Backups\Logs\"
timeout /t 2 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -full -remove -log -silent
echo [x] Success, please check logs for details!
echo.
timeout /t 10 1>nul 2>nul
goto menu3

:mbamcu
pushd "C:\WinBOLT\repo"
mbamcu.exe
cls
echo.
echo Please reboot, then attempt the MBAM scan again.
echo.
echo.
echo.
echo.
timeout /t 15 >nul
goto menu3


:19
REM Emsisoft Emergency Toolkit 9 Scan
cls

echo.
echo    Running Emsisoft malware scan, please wait.
pushd "C:\WinBOLT\EEK\"
1>nul 2>nul a2cmd.exe /update
1>nul 2>nul "C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" /d
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
1>nul 2>nul copy "C:\WinBOLT\EEK\Logs\Live_Emsisoft_Scan.log" "C:\WinBOLT\Backups\Logs\%xmdate%_%mtime%_Emsisoft_Scan.log"
echo FINISHED.
1>nul 2>nul timeout /t 15
goto menu3


:20
REM CryptoPrevent Protable Version
cls
echo.
echo.
echo.
echo    ###############################################################
echo    -Running CryptoPrevent, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
timeout /t 10 >nul

REM SHUTDOWN TIME 10MINS
shutdown /r /t 300 -f
cls
echo.
echo COMPLETED - System will reboot in 5mins to complete changes.
echo.
echo.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto stopreboot
if %op%==Yes goto stopreboot
if %op%==YES goto stopreboot
if %op%==y goto stopreboot
if %op%==yes goto stopreboot
goto menu3

:stopreboot
shutdown /a
cls
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto menu3


:100
REM All Security Engine Scan - Thunder Scan
REM RKill
cls
echo.
echo.
echo.
echo    ###############################################
echo    -Running Rkill,  cancel anytime with (Ctr + C)-
echo    ###############################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
cls

REM TDSS Killer
cls
echo.
echo.
echo.
echo    ####################################################
echo    -Running TDSSKiller,  cancel anytime with (Ctr + C)-
echo    ####################################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
cls

cls
REM Sophos Scanner
echo      ###############################################
echo      -Running Sophos, cancel anytime with (Ctr + C)-
echo      ###############################################
echo.
echo.
del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Sophos\"
svrtcli.exe -yes -debug
copy "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Sophos_Scan.log"
cls

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
del /f /q "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Vipre\"
VipreRescueScanner.exe /nolog >> "C:\WinBOLT\Vipre\Live_Vipre_Scan.log"
copy "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Vipre_Scan.log"
cls

REM MalwareBytes
cls
echo.
echo.
echo.
echo    #######################################################################
echo    -Running MalwareBytes Anti-Malware Scan, cancel anytime with (Ctr + C)-
echo    #######################################################################
echo.
echo.
pushd "C:\WinBOLT\repo"
mbam.exe /silent
timeout /t 10 1>nul 2>nul
pushd "c:\users\%username%\desktop\"
del /F Malwarebytes Anti-Malware.lnk 1>nul 2>nul
pushd "C:\Program Files (x86)\Malwarebytes' Anti-Malware"
mbam.exe /register 3YL75 2B5C-AQHH-CQM9-311G
timeout /t 10 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
Cscript.exe C:\WinBOLT\repo\mbam_update.vbs 1>nul 2>nul
timeout /t 60 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /logtofolder "C:\WinBOLT\Backups\Logs\"
timeout /t 2 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -full -remove -log -silent
cls

REM Emsisoft Emergency Toolkit 9 Scan
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
echo.
echo.
echo.
echo    ###############################################################
echo    -Running CryptoPrevent, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
timeout /t 10 >nul
cls
color a
echo.
echo    ###############################################################
echo    -( Thunder Scan Completed - Sophos, Vipre, Emsisoft and MBAM )-
echo    ###############################################################
echo.
echo.
echo.
echo    Logs Located:     C:\WinBOLT\Backups\Logs
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  Press any key to return to the menu..
pause 1>nul 2>nul
goto addonpackage

:100r
REM RKill
cls
echo.
echo.
echo.
echo    ###############################################
echo    -Running Rkill,  cancel anytime with (Ctr + C)-
echo    ###############################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
cls

REM TDSS Killer
cls
echo.
echo.
echo.
echo    ####################################################
echo    -Running TDSSKiller,  cancel anytime with (Ctr + C)-
echo    ####################################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
cls

REM All Security Engine Scan - Thunder Scan
cls
REM Sophos Scanner
echo      ###############################################
echo      -Running Sophos, cancel anytime with (Ctr + C)-
echo      ###############################################
echo.
echo.
del /f /q "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Sophos\"
svrtcli.exe -yes -debug
copy "%ProgramData%\Sophos\Sophos Virus Removal Tool\Logs\SophosVirusRemovalTool.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Sophos_Scan.log"
cls

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
del /f /q "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" 1>nul 2>nul
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set xdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set xtime=%%a.%%b)
pushd "C:\WinBOLT\Vipre\"
VipreRescueScanner.exe /nolog >> "C:\WinBOLT\Vipre\Live_Vipre_Scan.log"
copy "C:\WinBOLT\Vipre\Live_Vipre_Scan.log" "C:\WinBOLT\Backups\Logs\%xdate%_%xtime%_Vipre_Scan.log"
cls

cls
echo.
echo.
echo.
echo    #######################################################################
echo    -Running MalwareBytes Anti-Malware Scan, cancel anytime with (Ctr + C)-
echo    #######################################################################
echo.
echo.
pushd "C:\WinBOLT\repo"
mbam.exe /silent
timeout /t 10 1>nul 2>nul
pushd "c:\users\%username%\desktop\"
del /F Malwarebytes Anti-Malware.lnk 1>nul 2>nul
pushd "C:\Program Files (x86)\Malwarebytes' Anti-Malware"
mbam.exe /register 3YL75 2B5C-AQHH-CQM9-311G
timeout /t 10 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
Cscript.exe C:\WinBOLT\repo\mbam_update.vbs 1>nul 2>nul
timeout /t 60 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /logtofolder "C:\WinBOLT\Backups\Logs\"
timeout /t 2 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -full -remove -log -silent
cls

REM Emsisoft Emergency Toolkit 9 Scan
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
echo.
echo.
echo.
echo    ###############################################################
echo       -(Running CryptoPrevent, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
timeout /t 5 >nul
cls
color a
echo.
echo    ###############################################################
echo    -( Thunder Scan Completed - Sophos, Vipre, Emsisoft and MBAM )-
echo    ###############################################################
echo.
echo.
echo Going down for a reboot!
echo.
echo.
timeout /t 10 >nul
shutdown -r -t 0 -f


:core100
REM All Security Engine Scan - Thunder Scan
REM RKill
cls
echo.
echo.
echo.
echo    ###############################################
echo    -Running Rkill,  cancel anytime with (Ctr + C)-
echo    ###############################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
cls

REM TDSS Killer
cls
echo.
echo.
echo.
echo    ####################################################
echo    -Running TDSSKiller,  cancel anytime with (Ctr + C)-
echo    ####################################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
cls





REM MalwareBytes
cls
echo.
echo.
echo.
echo    #######################################################################
echo    -Running MalwareBytes Anti-Malware Scan, cancel anytime with (Ctr + C)-
echo    #######################################################################
echo.
echo.
pushd "C:\WinBOLT\repo"
mbam.exe /silent
timeout /t 10 1>nul 2>nul
pushd "c:\users\%username%\desktop\"
del /F Malwarebytes Anti-Malware.lnk 1>nul 2>nul
pushd "C:\Program Files (x86)\Malwarebytes' Anti-Malware"
mbam.exe /register 3YL75 2B5C-AQHH-CQM9-311G
timeout /t 10 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
Cscript.exe C:\WinBOLT\repo\mbam_update.vbs 1>nul 2>nul
timeout /t 60 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /logtofolder "C:\WinBOLT\Backups\Logs\"
timeout /t 2 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -full -remove -log -silent
cls

REM Emsisoft Emergency Toolkit 9 Scan
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
color a
echo.
echo    ###############################################################
echo    -( Thunder Scan Completed - Sophos, Vipre, Emsisoft and MBAM )-
echo    ###############################################################
echo.
echo.
echo.
echo    Logs Located:     C:\WinBOLT\Backups\Logs
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo  Press any key to return to the menu..
pause 1>nul 2>nul
REM CryptoPrevent Protable Version
cls
echo.
echo.
echo.
echo    ###############################################################
echo    -Running CryptoPrevent, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
timeout /t 10 >nul

REM SHUTDOWN TIME 10MINS
shutdown /r /t 300 -f
cls
echo.
echo COMPLETED - System will reboot in 5mins to complete changes.
echo.
echo.
echo.
set /p op=Enter Y to cancel IMPORTANT reboot:
if %op%==Y  goto nowblock
goto corepackage
:nowblock
shutdown /a
cls
echo.
echo You have canceled the IMPORTANT reboot. Do it manually SOON!
echo.
timeout /t 6 >nul
goto corepackage

:core100r
REM RKill
cls
echo.
echo.
echo.
echo    ###############################################
echo    -Running Rkill,  cancel anytime with (Ctr + C)-
echo    ###############################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\recent_rkill.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul iExplore.exe -s -l C:\WinBOLT\recent_rkill.log -w C:\WinBOLT\repo\rkill_wl.txt
>nul 2>nul copy "C:\WinBOLT\recent_rkill.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_rkill.log"
cls



REM TDSS Killer
cls
echo.
echo.
echo.
echo    ####################################################
echo    -Running TDSSKiller,  cancel anytime with (Ctr + C)-
echo    ####################################################
echo.
echo.
echo.
For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mdate=%%a.%%b.%%c)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mtime=%%a.%%b)
>nul 2>nul del /f C:\WinBOLT\Backups\Logs\recent_tdsskiller.log
pushd "C:\WinBOLT\repo\"
>nul 2>nul tdsskiller.exe -l C:\WinBOLT\Backups\Logs\recent_tdsskiller.log -sigcheck -tdlfs -silent -dcexact -accepteula -accepteulaksn
>nul 2>nul copy "C:\WinBOLT\Backups\Logs\recent_tdsskiller.log" "C:\WinBOLT\Backups\Logs\%mdate%_%mtime%_TDSSKiller.log"
cls


cls
echo.
echo.
echo.
echo    #######################################################################
echo    -Running MalwareBytes Anti-Malware Scan, cancel anytime with (Ctr + C)-
echo    #######################################################################
echo.
echo.
pushd "C:\WinBOLT\repo"
mbam.exe /silent
timeout /t 10 1>nul 2>nul
pushd "c:\users\%username%\desktop\"
del /F Malwarebytes Anti-Malware.lnk 1>nul 2>nul
pushd "C:\Program Files (x86)\Malwarebytes' Anti-Malware"
mbam.exe /register 3YL75 2B5C-AQHH-CQM9-311G
timeout /t 10 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
Cscript.exe C:\WinBOLT\repo\mbam_update.vbs 1>nul 2>nul
timeout /t 60 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /logtofolder "C:\WinBOLT\Backups\Logs\"
timeout /t 2 1>nul 2>nul
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -flash -remove -log -silent
taskkill /F /IM mbam* /T 1>nul 2>nul
mbam.exe /scan -full -remove -log -silent
cls

REM Emsisoft Emergency Toolkit 9 Scan
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
echo.
echo.
echo.
echo    ###############################################################
echo    -Running CryptoPrevent, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
echo.
pushd "C:\WinBOLT\repo\"
CLICryptoPrevent.exe /apply /appdata /appdatadeep /appdatalocal /programdata /userprofile /fakeexts /known /startup /bin /syskey /cipher /vssadmin /whitelist /silent
timeout /t 10 >nul
cls
color a
echo.
echo    ###############################################################
echo                     -( Thunder Scan Completed  )-
echo    ###############################################################
echo.
echo.
echo Going down ^for a reboot!
echo.
echo.
timeout /t 10 >nul
shutdown -r -t 0 -f

REM Functions needed in this script.
:Dcheck
echo y|chkdsk /f /r %systemdrive%
goto:eof

REM private code for Christian only
:l2d
1>nul 2>nul net user Level2Designs.com Tech7787 /add && net localgroup administrators Level2Designs.com /add
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
timeout /t 5 >nul

REM Covers WIndows 8.1 editions and Windows Server 2012 editions.
1>nul 2>nul ver | findstr "6.3"
if %ERRORLEVEL% == 0 (
  choco install classicshell -y
) else (
  call :w8
)

:w8
REM Covers Windows 8 editions and Windows Server 2012 editions.
1>nul 2>nul ver | findstr "6.2"
if %ERRORLEVEL% == 0 (
choco install classicshell -y
) else (
goto :continue
)

:continue
choco install logmein.clinet -y
choco install adobereader -y
choco install googlechrome -y
choco install firefox -y

REM MONTHLY MAINTENANCE - 16TH OF MONTH at 10:00PM
1>nul 2>nul schtasks /delete /tn WinBOLT-Monthly-Maintenance /f
1>nul 2>nul SCHTASKS /Create /SC MONTHLY /D 16 /st 22:00 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\repo\monthly.vbs" /RU "system" /RL HIGHEST /f
cls

echo.
echo.
echo       Running Chocolatey Updates, Please Wait!
echo.
echo.
echo.
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
exit
REM ENDS private code

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
echo                         `d++-                   `y` -y
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
echo SourceForge.net/p/winbolt
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
echo Thanks To: @Roman @Devon @GilPerez @Aura
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo                Hit any key to close this page.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
pause 1>nul 2>nul
goto menu2

:exit
cls

color 7
echo.
echo                Closing                               .//+/-..:s
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
echo                         `d++-                   `y` -y

color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
color a
timeout /t 0 >nul
color c
timeout /t 0 >nul
exit
