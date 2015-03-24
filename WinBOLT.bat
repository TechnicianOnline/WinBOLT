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
REM LAST UPDATED 03.20.2015
REM Current Version 1.0
REM ###################################################################################################################
REM ######################################## ( - Change Log and Version - ) ###########################################
REM ###################################################################################################################
REM **v.02: Added Registry Entry to disable UAC
REM **v.02: Added ccleaner monthly autoscheduler with customer config .INI file (Does NOT delete cookies)
REM **v.02: Added "Maintenance Script Autoschedule to Menu" runs every 30th and 15th of the month.
REM **v.02: Added malwarebytes to Autoschedule, silent quick scan and threat removal (if found). Non-silent update.
REM **v.02: Added second BATCH script (Monthly.bat) to Windows BOLT
REM **v.03: Added SelfAdminTest to BOLT.
REM **v.03: Added rename.vbs script to change Computer Host Name.
REM **v.03: Removed all Registry Apps
REM **v.03: Added third BATCH script (repos.bat), option settings for user
REM **v.03: Added fourth BATCH script (Monthly_VB.VBS), runs Monthly.bat silently
REM **v.04: Added HardwareInfo sub-menu
REM **v.04: Restructured entire Menu options
REM **v.04: Refined batch script
REM **v.04: Changed name from Windows Bolt to WinBOLT
REM **v.04: Removed MBAM and replaced with Emsisoft EEK
REM **v.04: Added emsisoft.bat, emsisoft_VB.vbs and EEK folder
REM **v.04: Refined Monthly.bat
REM **v.04: Added Custom Applications sub-menu
REM **v.04: Added Uninstall option to Custom Applications sub-menu
REM **v.04: Added autoscheduler reboot to FSC.
REM **v.04: Merged emsisoft.bat with monthly.bat, removed emsisoft_VB.vbs and emsisoft.bat
REM **v1.0: extracts all files to TEMP and moves to C:\WinBOLT\
REM **v1.0: revised code, audited all entries and uploaded to github.com/OnlineLabs
REM **v1.0: Added Windows Updates to Option #2 and Option#7
REM **v1.0: Fixed WinBOLT hang, verficiation check added before ROBOCOPY.
REM **v1.0: Added SSD defrag bypass for Option #6 and #7.
REM **v1.0: Major additions to hardware info Option #9
REM ###################################################################################################################
REM ###################################################################################################################

@echo off
title (- WinBOLTv1.0 - GitHub.com/OnlineLabs -)
REM Starting Windows Update as a time advantage for Option #2.
cd %windir%\system32\
wuauclt.exe /detectnow
IF EXIST C:\WinBOLT\EEK goto Verification
cls
color 5
md C:\WinBOLT\ >nul
cls
color 5
xcopy /q /y monthly.bat C:\WinBOLT\ >nul
cls
color 5
xcopy /q /y rename.vbs C:\WinBOLT\ >nul
cls
color 5
echo.
echo Preparing system requirements........
robocopy EEK C:\WinBOLT\EEK\ /MIR /R:1000 >nul
cls
goto recopy

:recopy
color 6
md C:\WinBOLT\ >nul
cls
color 5
xcopy /q /y monthly.bat C:\WinBOLT\ >nul
cls
color 5
xcopy /q /y rename.vbs C:\WinBOLT\ >nul
cls
color 5
echo Preparing system requirements........
robocopy EEK C:\WinBOLT\EEK\ /MIR /R:1000 >nul
cls
goto Verification

:Verification
cls

echo.
echo  ###############################################
echo  # Assure the following before running WinBOLT #
echo  ###############################################
echo  [X]  Full Local Administrator rights
echo  [X]  .NET Framework 3.5 and above
echo  [X]  PowerShell 2.0 and above
echo.
echo.   
set /p op=Do you meet the requirements? (Y or N):
if %op%==Y goto SelfAdminTest
if %op%==Yes goto SelfAdminTest
if %op%==yes goto SelfAdminTest
if %op%==y goto SelfAdminTest
goto exit

REM Self Admin Check
:SelfAdminTest
netstat -bno > NUL
IF %ERRORLEVEL% EQU 0 (
	cls
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
cd C:\WinBOLT\
color a
cls

echo.
echo    ######################################################################
echo    # WinBOLT v1.0 - Maintenance Automation Tool - GitHub.com/OnlineLabs #
echo    ######################################################################
echo.
echo     1)  Install Chocolatey
echo     2)  Run Windows Update and Chocolatey Updates
echo     3)  Install Custom Applications (Slow/Infected/New OS)
echo     4)  Enable Maintenance Script (Runs Monthly Each 30th/15th)
echo     5)  WinBOLT Tune Up - Delete Temp, Run CCLeaner, EEK update/scan/removal.
echo     6)  Defrag HDD, Sys File CHK, File Sys CHK (Auto reboot once completed)
echo     7)  All Of Thee Above (Does NOT include Opt#3)
echo     8)  Rename Computer Host Name
echo     9)  Get Hardware Information
echo.
echo     X)  Exit
echo.
echo.
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
if %op%==X goto exit
if %op%==x goto exit
if %op%==quit goto exit
if %op%==Q goto exit
if %op%==q goto exit
goto exit


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
choco update -y
choco update all -y
cd %windir%\system32\
wuauclt.exe /detectnow /updatenow


cls
echo COMPLETED - Update Chocolatey Apps
timeout /t 3 >nul
goto menu


:3
cls

echo.
echo     ####################################
echo     -WinBOLT v1.0 - Custom Applications-
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
echo       X)  Back to main menu
echo       S)  Shows installed appliactions
echo.
echo 	To UNinstall appliactions enter "U" before the number - (example: U1)
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
choco install pcdecrapifierportable -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#2
choco install ccleaner -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#3
choco install malwarebytes -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#4
choco install adwcleaner -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#5
choco install emet -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#6
choco install keepass -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#7
choco install nmap -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#8
choco install jrt -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#9
choco install angryip -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#10
choco install ditto -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#11
choco install combofix -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#12
choco install greenshot -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#13
choco instsall atom -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#14
choco install f.lux -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

:#15
choco install rkillportable -y
cls
echo COMPLETED
timeout /t 1 >nul
goto 3

REM UNINSTALL CUSTOM APPLICATIONS
:U#1
choco uninstall pcdecrapifierportable
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#2
choco uninstall ccleaner
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#3
choco uninstall malwarebytes
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#4
choco uninstall adwcleaner
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#5
choco uninstall emet
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#6
choco uninstall keepass
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#7
choco uninstall nmap
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#8
choco uninstall jrt
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#9
choco uninstall angryip
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#10
choco uninstall ditto
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#11
choco uninstall combofix
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#12
choco uninstall greenshot
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#13
choco instsall atom
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#14
choco uninstall f.lux
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:U#15
choco uninstall rkillportable
cls
echo COMPLETED - Uninstall
timeout /t 1 >nul
goto 3

:show
choco list -localonly
pause
goto 3

:4
cls

echo.
echo.
echo       Installing Maintenance Script Autoschedule; Please Wait!
echo.
echo.
echo.

REM MONTHLY MAINTENANCE - 30TH AND 15TH OF MONTH
echo Y|SCHTASKS /Create /SC MONTHLY /D 30;15 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\monthly.bat"

cls
echo COMPLETED - Maintenance Script Autoschedule
timeout /t 3 >nul
goto menu



:5
cls

echo.
echo.
echo       Windows Tune Up, Please Wait!
REM Installs CCLEANER+Config/RunsEEK+Updates/DisablesUAC/DelTempFiles/RunsCustomCCleaner
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
REM REGISTRY ENTRY DISABLES UAC AND SUPRESSES ALL NOTIFICATIONS (WILL TAKE EFFECT UPON REBOOT; DOES NOT FORCE REBOOT)
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0x0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
cd C:\Program Files\CCleaner\
ccleaner.exe /clean
cls
echo.
echo.
echo.
echo
echo    ###############################################################
echo    -Running DEEP EmsiSoft EEK scan, cancel anytime with (Ctr + C)-
echo    ###############################################################
echo.
echo.
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
Set output=File Scan_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.txt
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\" /d

cls
echo COMPLETED - Windows Tune up!
timeout /t 3 >nul
goto menu


:6
cls
color a
echo.
echo Are you running an SSD?
echo Solid State Drives should NOT be defragged.
echo.

set /p op=Enter (Y or N):
if %op%==N goto 6no
if %op%==No goto 6no
if %op%==no goto 6no
if %op%==n goto 6no
if %op%==Y goto 6yes
if %op%==Yes goto 6yes
if %op%==yes goto 6yes
if %op%==y goto 6yes
goto exit

:6no
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

:6yes
echo.
echo.
echo      Skipping Defraging but running File System Check and File System Integrity Check, Please Wait!
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


:7
cls
color a
echo.
echo Are you running an SSD?
echo Solid State Drives should NOT be defragged.
echo.

set /p op=Enter (Y or N):
if %op%==N goto 7no
if %op%==No goto 7no
if %op%==no goto 7no
if %op%==n goto 7no
if %op%==Y goto 7yes
if %op%==Yes goto 7yes
if %op%==yes goto 7yes
if %op%==y goto 7yes
goto exit

:7no
echo.
echo.
echo       Running EVERYTHING, Please Wait!
echo.
echo   This does NOT incude Custom Applications!
echo.
echo.
echo.
cd %windir%\system32\
wuauclt.exe /detectnow /updatenow
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
echo.
choco update -y
choco update all -y
choco install ccleaner -y
REM REGISTRY ENTRY DISABLES UAC AND SUPRESSES ALL NOTIFICATIONS (WILL TAKE EFFECT UPON REBOOT; DOES NOT FORCE REBOOT)
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0x0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
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
REM MONTHLY MAINTENANCE - 30TH AND 15TH OF MONTH
echo Y|SCHTASKS /Create /SC MONTHLY /D 30;15 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\monthly.bat"
echo.
cd C:\Program Files\CCleaner\
ccleaner.exe /clean
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
Set output=File Scan_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.txt
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\" /d
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

:7yes
echo.
echo.
echo       Running EVERYTHING, Please Wait!
echo.
echo   This does NOT incude Custom Applications!
echo.
echo.
echo.
cd %windir%\system32\
wuauclt.exe /detectnow /updatenow
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
echo.
choco update -y
choco update all -y
choco install ccleaner -y
REM REGISTRY ENTRY DISABLES UAC AND SUPRESSES ALL NOTIFICATIONS (WILL TAKE EFFECT UPON REBOOT; DOES NOT FORCE REBOOT)
REG ADD HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0x0 /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v ConsentPromptBehaviorAdmin /t REG_DWORD /d 0 /f
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
REM MONTHLY MAINTENANCE - 30TH AND 15TH OF MONTH
echo Y|SCHTASKS /Create /SC MONTHLY /D 30;15 /TN "WinBOLT-Monthly-Maintenance" /TR "C:\WinBOLT\monthly.bat"
echo.
cd C:\Program Files\CCleaner\
ccleaner.exe /clean
pushd "C:\WinBOLT\EEK\"
a2cmd.exe /update
set hr=%time:~0,2%
if "%hr:~0,1%" equ " " set hr=0%hr:~1,1%
Set output=File Scan_%date:~-4,4%%date:~-10,2%%date:~-7,2%_%hr%%time:~3,2%%time:~6,2%.txt
"C:\WinBOLT\EEK\a2cmd.exe" /f=C /deep /rk /m /t /a /n /ac /l="C:\WinBOLT\EEK\Logs\" /d
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
goto menu


:8
cls

cd C:\WinBOLT\
Set /P op=Provide the new desired Computer name:
IF  "%op%"==""GOTO Error
rename.vbs %op%

cls
echo COMPLETED - Computer Host Name Changed To: %op%
timeout /t 5 >nul
goto menu


:9
cls

echo.
echo.
echo      Getting system information.
echo.
echo.
echo.
echo      Please scroll up and down to view!
echo.
echo.
echo.
echo.
echo.
timeout /t 6 >nul
goto hardwareinfo

:hardwareinfo
cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Full BIOS Information:
echo ----------------------
wmic BIOS get Manufacturer,Name,SMBIOSBIOSVersion,Version
echo.
echo Motherboard Information:
echo ------------------------
wmic baseboard get product, Manufacturer, version, serialnumber
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Processor Chipset Information:
echo ------------------------------
wmic CPU get Name,NumberOfCores
wmic cpu get CurrentClockSpeed,MaxClockSpeed
echo.
echo Processor physical bit architecture:
echo ------------------------------------
wmic cpu get AddressWidth | findstr /V AddressWidth
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Windows Operating System Information:
echo -------------------------------------
wmic OS get Caption,CSDVersion,OSArchitecture,Version
echo.
echo Windows Installation Date:
echo --------------------------
systeminfo | findstr /C:"Original"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo RAM - Physical DIMM Slot Information:
echo ------------------------------------
wmic memorychip get Manufacturer, PartNumber, SerialNumber
systeminfo | findstr /C:"Total Physical Memory"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Hard Drive Disk Interface - Name -  S.M.A.R.T Status:
echo ----------------------------------------------------
wmic DISKDRIVE get InterfaceType, Caption, Size, Status
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Graphical Devices - Driver Version
echo ----------------------------------
wmic PATH Win32_VideoController GET Description,DriverVersion | findstr /V LogMeIn
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Network Interface Card Information:
echo [TRUE=Active NIC] [FALSE=Inactive NIC]
echo --------------------------------------
wmic NIC get Description,MACAddress,NetEnabled | findstr "TRUE"
wmic NIC get Description,MACAddress,NetEnabled | findstr "FALSE"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Dell Service Tag:
echo -----------------
wmic bios get serialnumber
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

set /p op=Go back to menu? (Y or N)
if %op%==Y  goto menu
if %op%==Y goto menu
if %op%==Yes goto menu
if %op%==yes goto menu
if %op%==y goto menu

:exit
cls

color 7
echo.
echo.
echo.
echo           WinBOLT has been closed, take care!
echo.
echo.

timeout /t 5 >nul
exit
