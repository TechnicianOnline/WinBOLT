@echo off
color a
set timestamp=%DATE:~4,2%.%DATE:~7,2%.%DATE:~-4%.%TIME:~0,2%.%TIME:~3,2%
set profile=%userdomain%_%computername%_%username%

echo.
echo    #################################################
echo    # Command Repeater - Manuel Test - Do Not Close #
echo    #################################################
echo.
echo.
echo. [OUTPUT] - C:\%timestamp%_%profile%_Command_Output.txt
echo.
echo.
echo. CLOSE COMMAND PROMPT WHEN FINISHED.
ECHO.
echo.

REM -------- ENTER YOUR COMMAND BELOW--------
REM ---- MAKE SURE TO LEAVE THIS PART ALONE " >C:\%timestamp%_%profile%_Command_Output.txt"
netstat -bno >C:\%timestamp%_%profile%_Command_Output.txt

:loop
netstat -bno >>C:\%timestamp%_%profile%_Command_Output.txt
echo ###########################################################>>C:\%timestamp%_%profile%_Command_Output.txt
echo ###########################################################>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #		     -[Log Break for Review]-             #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo. >>C:\%timestamp%_%profile%_Command_Output.txt
echo. >>C:\%timestamp%_%profile%_Command_Output.txt
echo. |time |find "current" >>C:\%timestamp%_%profile%_Command_Output.txt
echo. |date |find "current" >>C:\%timestamp%_%profile%_Command_Output.txt 
echo. >>C:\%timestamp%_%profile%_Command_Output.txt
echo. >>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo #							  #>>C:\%timestamp%_%profile%_Command_Output.txt
echo ###########################################################>>C:\%timestamp%_%profile%_Command_Output.txt
echo ###########################################################>>C:\%timestamp%_%profile%_Command_Output.txt
timeout /t 60 >nul
goto loop
