#NoEnv
#Warn
SendMode Input

EnvGet, HomeDir, USERPROFILE
SetWorkingDir %A_ScriptDir%

; TODO: somehow filter this hook more
; #IfWinActive ahk_class ConsoleWindowClass
~^!u::
  ; Retrieve the title of the active window
  WinGetTitle, activeTitle, A
  ; Check if the window title contains "Windows PowerShell", "powershell", "Command Prompt", or "cmd"
  if (InStr(activeTitle, "Windows PowerShell") or InStr(activeTitle, "powershell") or InStr(activeTitle, "Command Prompt") or InStr(activeTitle, "cmd")) {
    Send, ^{Home} ; Press Ctrl+Home
  }
  else {
    ; TODO: verify that this is not recursive and defaults to the default behavior of the key
    Send, ^!u
  }
  return
; #IfWinActive

; TODO: somehow filter this hook more
; #IfWinActive ahk_class ConsoleWindowClass
~^!k::
  ; Retrieve the title of the active window
  WinGetTitle, activeTitle, A
  ; Check if the window title contains "Windows PowerShell", "powershell", "Command Prompt", or "cmd"
  if (InStr(activeTitle, "Windows PowerShell") or InStr(activeTitle, "powershell") or InStr(activeTitle, "Command Prompt") or InStr(activeTitle, "cmd")) {
    Send, ^{End} ; Press Ctrl+Home
  }
  else {
    ; TODO: verify that this is not recursive and defaults to the default behavior of the key
    Send, ^!k
  }
  return
; #IfWinActive

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S ; NOTE: this acts as a toggle on and off
^!r::Reload   ; Reload script with Ctrl+Alt+R
^!Esc::ExitApp  ; Exit script with Escape key
