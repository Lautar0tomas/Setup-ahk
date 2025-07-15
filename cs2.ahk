  #NoEnv
#Persistent
#SingleInstance force

toggle := false

F8::
toggle := !toggle
if toggle {
    Run, C:\nircmd\nircmd.exe muteappvolume cs2.exe 1
} else {
    Run, C:\nircmd\nircmd.exe muteappvolume cs2.exe 0
}
return     


Pause::
targetID := "ahk_id 0x20758"  ; ← REEMPLAZÁ con tu ID exacto

WinActivate, %targetID%
WinWaitActive, %targetID%, , 1
SendInput, {Space}
return

; con el Ctrl+Alt+I podras obtener la id de la ventana para reemplazarla en "ahk_id .0x..  "  el de arriba para que 
;funcione cada que reinicies el navegador . 
^!i::  
WinGet, hwnd, ID, A
WinGetTitle, title, A
MsgBox, Esta ventana:`n%title%`nID: %hwnd%
return

^+F4:: ; Ctrl + Shift + F4 para suspender la maquina 
Run, C:\NirCmd\nircmd.exe standby
return

