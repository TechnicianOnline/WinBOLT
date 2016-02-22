@echo on
:acaMONITOR
timeout /t 2 >nul
tasklist /fi "windowtitle eq - AdwCleaner - Information -" | find /i "adwcleaner.exe" > nul
if not errorlevel 1 (taskkill /f /im "adwcleaner.exe") else (
  goto acaMONITOR
)
timeout /t 2 >nul
taskkill /f /t /im "AutoIt3.exe"
SET src_folder=c:\AdwCleaner
SET tar_folder=c:\WinBOLT\Backups\Logs\AdwCleaner

for /f %%a IN ('dir "%src_folder%" /b') do move %src_folder%\%%a %tar_folder%

exit
