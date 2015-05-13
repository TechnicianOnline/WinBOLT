###############################################################################################################
# WinBOLT v2.0
# Maintenance Automation Tool
###############################################################################################################

This tool is created by a Technician for the Technicians. This will simplify your job on the Windows Operating System. The maintenance work more often than not becomes perpetual. My ultimate goal and function of WinBOLT was to automate the standard process of annoying Windows Updates, Malware Scanning, running CCleaner and task like backing up the local users files.

This tool is simple, effective and very useful.

This runs the Emsisoft's Commandline Scanner. If this is for personal use you don't have to worry about EEK license. Comercial users must purchase scans directly from Emsisoft.

###############################################################################################################
# Instructions
###############################################################################################################

To start using WinBOLT, you must run WinBOLT.cmd with Administrator rights.

It's important to know option #6 is the most common option as it does the "full blown maintenance".

###############################################################################################################
# Details about WinBOLT Options
###############################################################################################################

Options #1
will install Chocolatey NuGet the Machine Package Manager.
Saves you time from manually copying/pasting the long install command to CMD/Powershell.

Options #2
Will force Windows to download/install all update definitions found without prompt.
Will update Chocolatey NuGet and any installed applications through Chocolatey.
Using this saves you lots of manual work by automating Windows Updates.
Using this will allow you to install applications directly through Chocolatey Nuget and update them constantly.
Using this with option #3 allows it to run each month, option #6 also covers option #2 and option #7.

Options #3
Will create a Windows Task to run C:\WinBOLT\monthly.bat each 30'th and 15'th of the month.
Using this will allow handsfree maintenance on all the computers you want.
monthly.bat will run Windows Updates, ccleaner and allow Emsisoft CLS to run in the background.

Options #4
Will run a basic Windows Tune up. Deleting temp files, running CCLeaner and Emsisoft CLS.
Using this will allow you to quickly do basic maintenance quickly, without involving other options above or below.

Options #5
Will defragment the C:\ drive, run a System File Check for currupted Windows system files.
Will scheduled File System Check on next reboot.
Using this will really help maintain a Windows Operating System but is a very long proccess.
Using this will ask for a reboot to complete the File System Check, it will being during startup.

Option #6
Will do everything listed above, options #1 through #5.
Using this will pretty much cover all the basis of Windows Maintenance and is the most common option.

Option #7
Will offer another menu to install applications as desired.
Using this will allow a variety of tools at your fingertips to troubleshoot/setup a new/old computer.

Option #8
Will allow you to rename the computer hostname.
Use this option to set a new hostname in seconds.

Option #9
Will provide you very specific and detailed information on the physical hardware of the computer.
Using this option will save you time from physically opening the computer to get detailed information like model numbers.
Using this option on Servers running Windows serves especially well, no need to schedule downtime to get hardware info.

Option #10
Will run a local backup of the user running WinBOLT and give you the option to select the destination.
Will backup the entire users profile and extract the Windows Serial Key to re-use on the next activation.
Using this will save you time to gather the users files if you're planning to re-image the OS.

Option #11
Will extract the Windows Serial Key.
Using this will save you time from searching for it and installing programs to do it for you.
