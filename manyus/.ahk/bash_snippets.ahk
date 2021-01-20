#NoEnv
#Warn
SendMode Input

EnvGet, HomeDir, USERPROFILE
SetWorkingDir %A_ScriptDir%

^!l::
Send, l=(); for ele in ${l[@]}; do echo $ele; done
return

^!f::
find . -maxdepth 5 -regextype egrep -iregex '.*pattern.*' -type d -print0 | xargs --null -I{} echo {}
return

^!p::Pause    ; Pause script with Ctrl+Alt+P
^!s::Suspend  ; Suspend script with Ctrl+Alt+S
^!r::Reload   ; Reload script with Ctrl+Alt+R
^!Esc::ExitApp  ; Exit script with Escape key
  