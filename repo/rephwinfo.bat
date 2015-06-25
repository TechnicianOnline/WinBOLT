@echo off

title (- WinBOLT - GitHub.com/OnlineLabs -)

winmgmt /verifyrepository || goto fixwmic

goto stap
:fixwmic
color CF
echo.
echo    #######################################################
echo    # WinBOLT v%Current_Version% - PROBLEM FOUND - GitHub.com/OnlineLabs #
echo    #######################################################
echo.
echo.
echo.
echo WinBOLT has found major problems
echo with your Windows Management Instrumentation (WMI) subsystem.
echo.
echo Only continue if you know what you're doing.
echo.
echo.
set /p op=Do you want to continue from this point? (Y or N):
if %op%==Y goto doitx
if %op%==Yes goto doitx
if %op%==yes goto doitx
if %op%==y goto doitx
if %op%==N goto exit
if %op%==No goto exit
if %op%==no goto exit
if %op%==n goto exit
echo Incorrect input, try again.
timeout /t 1 >nul

:doitx
color CF
echo.
echo    #######################################################
echo    # WinBOLT v%Current_Version% - PROBLEM FOUND - GitHub.com/OnlineLabs #
echo    #######################################################
echo.
echo.
echo.
echo WinBOLT has found major problems
echo with your Windows Management Instrumentation (WMI) subsystem.
echo.
echo Only continue if you know what you're doing.
echo.
echo.
set /p op=ARE YOU SURE? (Y or N):
if %op%==Y goto doit
if %op%==Yes goto doit
if %op%==yes goto doit
if %op%==y goto doit
goto exit
timeout /t 1 >nul

:doit
cd /d c:\temp
if not exist %windir%\system32\wbem goto TryInstall
cd /d %windir%\system32\wbem
net stop winmgmt
winmgmt /kill
if exist Rep_bak rd Rep_bak /s /q
rename Repository Rep_bak
for %%i in (*.dll) do RegSvr32 -s %%i
for %%i in (*.exe) do call :FixSrv %%i
for %%i in (*.mof,*.mfl) do Mofcomp %%i
net start winmgmt
goto stap
 
:FixSrv
if /I (%1) == (wbemcntl.exe) goto SkipSrv
if /I (%1) == (wbemtest.exe) goto SkipSrv
if /I (%1) == (mofcomp.exe) goto SkipSrv
%1 /RegServer
 
:SkipSrv
goto stap
 
:TryInstall
if not exist wmicore.exe goto stap
wmicore /s
net start winmgmt

:stap
color a

cls
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Full BIOS Information:
echo ----------------------
wmic BIOS get Manufacturer,Name,SMBIOSBIOSVersion,Version
echo.
echo Motherboard Information:
echo ------------------------
wmic baseboard get product, Manufacturer, version, serialnumber
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Windows Operating System Information:
echo -------------------------------------
wmic OS get Caption,CSDVersion,OSArchitecture,Version
echo.
echo Windows Installation Date:
echo --------------------------
systeminfo | findstr /C:"Original"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo RAM - Physical DIMM Slot Information:
echo ------------------------------------
wmic memorychip get Manufacturer, PartNumber, SerialNumber
systeminfo | findstr /C:"Total Physical Memory"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Hard Drive Disk Interface - Name -  S.M.A.R.T Status:
echo ----------------------------------------------------
wmic DISKDRIVE get InterfaceType, Caption, Size, Status
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Graphical Devices - Driver Version
echo ----------------------------------
wmic PATH Win32_VideoController GET Description,DriverVersion | findstr /V LogMeIn
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Network Interface Card Information:
echo [TRUE=Active NIC] [FALSE=Inactive NIC]
echo --------------------------------------
wmic NIC get Description,MACAddress,NetEnabled | findstr "TRUE"
wmic NIC get Description,MACAddress,NetEnabled | findstr "FALSE"
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo.
echo Dell Service Tag:
echo -----------------
wmic bios get serialnumber
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

REM pop up script when finished
echo set WshShell = WScript.CreateObject("WScript.Shell") > %tmp%\tmp.vbs
echo WScript.Quit (WshShell.Popup( "WinBOLT has completed your hardware scan" ,10 ,"WinBOLT Hardware Info", 0)) >> %tmp%\tmp.vbs
cscript /nologo %tmp%\tmp.vbs
if %errorlevel%==1 (
  echo.
) else (
  echo.
)
del %tmp%\tmp.vbs
echo Scroll up or down to view detailed info on your computer.
echo.
echo Hit any key to close this page.
echo.
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo ******************************************************************************
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1>nul 2>nul pause
exit
