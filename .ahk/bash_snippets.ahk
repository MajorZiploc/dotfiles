#NoEnv
#Warn
SendMode Input

EnvGet, HomeDir, USERPROFILE
SetWorkingDir %A_ScriptDir%

^!l::
Send, l=(); for ele in ${{}l[@]{}}; do echo $ele; done
return

^!f::
Send, find . -maxdepth 5 -regextype egrep -iregex '.*pattern.*' -type d -print0 | xargs --null -I{{}{}} echo {{}{}}
return

^!Esc::ExitApp  ; Exit script with Escape key
  