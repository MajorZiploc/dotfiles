#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Recommended for catching common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

EnvGet, HomeDir, USERPROFILE
SetWorkingDir %HomeDir%

ComputerScript = %A_ScriptDir%\%A_ComputerName%.ahk
if FileExist(ComputerScript) {
    Run "autohotkey.exe" %ComputerScript%
}

; keyboard alternate keys
+Media_Play_Pause::Send, {Media_Stop}
^Media_Play_Pause::Send, {Media_Stop}
Break::AppsKey ; alternate context menu key

; shortcuts
RunActivate(command, asAdmin := false) {
    if asAdmin {
        Run *RunAs %command%,,,OutputPID
    } else {
        Run %command%,,,OutputPID
    }
    WinWait, ahk_pid %OutputPID%
    WinActivate, ahk_pid %OutputPID%
}
Reactivate(prog) {
    SetTitleMatchMode, 2
    WinActivate, %prog%
}
#c::RunActivate("powershell")
#^c::RunActivate("powershell", true)
#v::RunActivate("C:\Program Files\Vim\vim82\gvim.exe")
#b::RunActivate("C:\Program Files\Git\git-bash.exe")
#k::RunActivate("C:\Program Files (x86)\Koffee\koffee.exe")
#^k::RunActivate("C:\Program Files (x86)\Koffee\koffee.exe", true)
#!k::Reactivate("Koffee v")

