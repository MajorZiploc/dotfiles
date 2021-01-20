#NoEnv
#Warn
SendMode Input

EnvGet, HomeDir, USERPROFILE
SetWorkingDir %A_ScriptDir%

^!l::
Send, l=(); for ele in ${l[@]}; do echo $ele; done
return

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R
^!Esc::ExitApp  ; Exit script with Escape key
  