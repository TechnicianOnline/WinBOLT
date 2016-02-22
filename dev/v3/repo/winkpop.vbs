Option Explicit
Dim WshShell,RegKey,WindowsKey,LogFile,fso
Set WshShell = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")
RegKey = "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"
WindowsKey = ConvertToKey(WshShell.RegRead(RegKey))
LogFile = "C:\WinBOLT\Backups\Logs\windows_serial_key_backup.log"
if fso.FileExists(LogFile) Then 
    fso.DeleteFile LogFile
end If
MsgBox WindowsKey,VbInformation,WindowsKey 
Call WriteLog(WindowsKey,LogFile)
WshShell.Run LogFile
'***********************************************************************************************************
Function ConvertToKey(Key)
    Const KeyOffset = 52
    Dim i,Chars,Cur,x,KeyOutput
    i = 28
    Chars = "BCDFGHJKMPQRTVWXY2346789"
    Do
        Cur = 0
        x = 14
        Do
            Cur = Cur * 256
            Cur = Key(x + KeyOffset) + Cur
            Key(x + KeyOffset) = (Cur \ 24) And 255
            Cur = Cur Mod 24
            x = x -1
        Loop While x >= 0
        i = i -1
        KeyOutput = Mid(Chars, Cur + 1, 1) & KeyOutput
        If (((29 - i) Mod 6) = 0) And (i <> -1) Then
            i = i -1
            KeyOutput = "-" & KeyOutput
        End If
    Loop While i >= 0
    ConvertToKey = KeyOutput
End Function
'*************************************************************************************************************
Sub WriteLog(strText,LogFile)
    Dim fs,ts 
    Const ForAppending = 8
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set ts = fs.OpenTextFile(LogFile,ForAppending,True)
    ts.WriteLine strText
    ts.Close
End Sub
'**************************************************************************************************************
