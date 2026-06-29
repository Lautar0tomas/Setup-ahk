#NoEnv
#Persistent
#SingleInstance force

; Coordenadas en pantalla
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

; Variables globales
last_id := ""
muteStates := {}

; Timer para centrar el cursor al cambiar de ventana activa
SetTimer, CheckActiveWindow, 50

; Fin de la sección automática
return

; ========== Controles del timer (cursor-ventana) ==========
~LButton:: SetTimer, CheckActiveWindow, Off
~RButton:: SetTimer, CheckActiveWindow, Off
~!Tab::   SetTimer, CheckActiveWindow, On
~LWin::   SetTimer, CheckActiveWindow, On
~!F4::    SetTimer, CheckActiveWindow, On
~MButton:: SetTimer, CheckActiveWindow, Off

; ========== Subrutina para centrar el cursor ==========
CheckActiveWindow:
    WinGet, current_id, ID, A
    if (current_id != last_id) {
        last_id := current_id
        Sleep, 50
        WinGet, MinMax, MinMax, ahk_id %current_id%
        if (MinMax = -1)   ; minimizada → salir
            return
        WinGetPos, X, Y, Width, Height, ahk_id %current_id%
        if (Width > 0 && Height > 0) {
            centerX := X + (Width / 2)
            centerY := Y + (Height / 2)
            MouseMove, %centerX%, %centerY%, 0
        }
    }
return

; ========== Redefinición de Alt (evita menú) ==========
Alt::
    if (GetKeyState("Ctrl","P") || GetKeyState("Shift","P")) {
        Send {Alt Down}
        KeyWait, Alt
        Send {Alt Up}
        return
    } else {
        KeyWait, Alt
        if (A_PriorKey = "Alt")
            Send {Blind}{vkFF}
        return
    }
return

; ========== Hotkey F8: silenciar/activar volumen de la app activa ==========
F8::
    WinGet, pid, PID, A
    WinGet, processName, ProcessName, A

    ; Detectar navegadores (por nombre de proceso)
    if (processName = "chrome.exe" or processName = "msedge.exe") {
        if (!muteStates.HasKey(processName))
            muteStates[processName] := false

        muteStates[processName] := !muteStates[processName]

        if (muteStates[processName])
            Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume %processName% 1
        else
            Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume %processName% 0
    } else {
        ; Resto de aplicaciones (por PID)
        if (!muteStates.HasKey(pid))
            muteStates[pid] := false

        muteStates[pid] := !muteStates[pid]

        if (muteStates[pid])
            Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume /%pid% 1
        else
            Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume /%pid% 0
    }
return