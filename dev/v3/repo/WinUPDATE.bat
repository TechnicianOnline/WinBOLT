@echo off
cls
color a

echo.
echo ###################################################
echo # Downloading WinBOLT Addon Package; please wait. #
echo ###################################################
echo.
echo.
echo.
echo.
bitsadmin /transfer myDownloadJob /download /priority foreground http://sourceforge.net/projects/winbolt/files/Addon_Package/WinBOLT_v3.1_Addon.exe c:\WinBOLT\Backups\Logs\WinBOLT_v3.1_Addon.exe
1>NUL 2>NUL timeout /t 3
pushd "C:\WinBOLT\Backups\Logs"
1>NUL 2>NUL timeout /t 1
WinBOLT_V3.1_Addon.exe
exit
