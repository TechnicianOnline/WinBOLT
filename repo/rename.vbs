const HKLM = &H80000002

Set WshShell = CreateObject("WScript.Shell")
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set oNetwork = CreateObject("WScript.Network")

strCurrentComputerName = oNetwork.ComputerName

strNewName = Wscript.arguments.Item(0)

strKeyPath = "System\CurrentControlSet\Control\ComputerName\ComputerName"
set objReg = GetObject("winmgmts:\\" & strCurrentComputerName & "\root\default:StdRegProv")
intRC = objReg.SetStringValue(HKLM, strKeyPath, "ComputerName", strNewName)

if intRC <> 0 Then
MSGBOX("Error setting ComputerName value: " & intRC)
Else

end if

strKeyPath = "System\CurrentControlSet\Services\Tcpip\Parameters"
intRC = objReg.SetStringValue(HKLM, strKeyPath, "NV Hostname", strNewName)
if intRC <> 0 Then
MsgBox("Error setting NV Hostname value: " & intRC)
Else

end if
