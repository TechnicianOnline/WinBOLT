DIM fso, NewsFile, WshShell

Set WshShell = CreateObject("WScript.Shell")

Set fso = CreateObject("Scripting.FileSystemObject")
Set write2File = fso.CreateTextFile("C:\WinBOLT\Backups\Logs\windows_serial_key_backup.log", True)
write2File.WriteLine(ConvertToKey(WshShell.RegRead("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId")))
write2File.Close

Function ConvertToKey(Key)
Const KeyOffset = 52
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
