

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*****************************************************  ( - WinBOLT v3.1 - ) *************************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*********************************************  ( - Maintenance Automation Tool - ) ****************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This tool is created by a Technician for the Technicians.
This will simplify your job on the Windows Operating System.
Working with these systems, more often than not tasks like maintenance becomes perpetual.
With that in mind, my ultimate goal and function of WinBOLT was simple, fool proof secure automation.
WinBOLT automats the standard process of annoying Windows Updates, Malware Scans, running CCleaner etc.

This tool is simple, effective and powerful.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
***************************************************** ( - Instructions - ) ****************************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To start using WinBOLT, you must run WinBOLT.cmd with Administrator rights.

It's important to know option #6 is the most common option as it does the "full blown maintenance".

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*************************************************** ( - Guide / Menu Options- ) ********************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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
Will run a basic Windows Tune up. Deleting temp files, running CCLeaner Sophos CLS, Emsisoft CLS and apply CryptoPreventor
Using this will allow you to quickly do basic maintenance quickly, without involving other options above or below.

Options #5
Will defragment the C:\ drive, run a System File Check for currupted Windows system files.
Will scheduled File System Check on next reboot.
Using this will really help maintain a Windows Operating System but is a very long proccess.
Using this will ask for a reboot to complete the File System Check, it will being during startup.

[X] Option #6 (Recommended)
Will do everything listed above, options #1 through #5.
Using this will pretty much cover all the basis of Windows Maintenance and is the most common option.

######
######
######
######
######
YOU WILL HAVE TO ENTER OPTION "N" TO CONTINUE TO THE 2nd Menu!
######
######
######
######
######

Option #7
Will offer another menu to install applications as desired.
Using this will allow a variety of tools at your fingertips to troubleshoot/setup a new/old computer.

Option #8
Will provide you very specific and detailed information on the physical hardware of the computer.
Using this option will save you time from physically opening the computer to get detailed information like model numbers.
Using this option on Servers running Windows serves especially well, no need to schedule downtime to get hardware info.


Option #9
Special Tools and Actions Menu 
Misc options that are geared for advanced users.


######
######
######
######
######
YOU WILL HAVE TO ENTER OPTION "9" TO CONTINUE TO THE 3rd Menu!
######
######
######
######
######


Option#10
Will allow you to rename the computer hostname.
Use this option to set a new hostname in seconds.

Option #11
Will run a local backup of the user running WinBOLT and give you the option to select the destination.
Will backup the entire users profile and extract the Windows Serial Key to re-use on the next activation.
Using this will save you time to gather the users files if you're planning to re-image the OS.

Option #12
Will extract the Windows Serial Key.
Using this will save you time from searching for it and installing programs to do it for you.

Option #13
This will clear all pending and suspended spools on the machine.
Common fix for printing issues.

Option #14
RKill - Stops active malware programs

Option #15
Kaspersky TDSSKilller - Full System Scan

Option #16
Sophos Virus Removal Tool - Full System Scan

Option #17
VIPRE Rescue - Full System Scan

Option #18
MalwareBytes Anti-Malware - Full System Scan

Option #19
Emsisoft Command Line Scanner - Full System Scan

Option #20
CryptoPreventor - Will apply protection against crypto malware.

Option #100 - Thunder Scan
Full system scan with all resources.
Rkill, TDRSSKiller, Sophos, Vipre, MalwareBytes, Emsisoft and CryptoPreventor.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
********************************************************  ( - Disclaimer - ) ************************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Provided without warranty, either expressed or implied
Product is licened under GNU General Public v2

This runs the Emsisoft anti-malware CLI and Sophos CLI anti-virus to counter threats effectively.
Comercial users must purchase license rights each perspective software used by WinBOLT.
WinBOLT itself is free for the home computers, all else much purchase a license.

Sales Contact: Christian_V@live.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
******************************************************  ( - WinBOLT Creator - ) ********************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

License: GNU GENERAL PUBLIC LICENSE
Created by Christian Vazquez
Email:Christian_V@live.com 
Github.com/OnlineLabs
Created 12/13/14

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*************************************************  ( - Special Thanks To - ) ***************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Roman
- Awesome feedback and tested out all my crazy beta builds. Great ideas to push and grow WinBOLT. Thanks for the motivation. <3

Devon
- Great help to go into the right direction, suggested new methods and helped refine my code.

Aura
- Provided the most detailed feedback of anyone, with his suggestion I redesigned the layout of WinBOLT.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*************************************************  ( - Thank you for downloading - ) ***************************************************************
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
