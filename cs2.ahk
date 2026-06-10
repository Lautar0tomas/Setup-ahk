#NoEnv
#Persistent
#SingleInstance force

muteStates := {}

F8:: 
WinGet, pid, PID, A
WinGet, processName, ProcessName, A

; detectar navegadores
if (processName = "chrome.exe" or processName = "msedge.exe") {
    
    if (!muteStates.HasKey(processName))
        muteStates[processName] := false

    muteStates[processName] := !muteStates[processName]

    if (muteStates[processName])
        Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume %processName% 1
    else
        Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume %processName% 0

} else {
    ; comportamiento normal (PID)
    if (!muteStates.HasKey(pid))
        muteStates[pid] := false

    muteStates[pid] := !muteStates[pid]

    if (muteStates[pid])
        Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume /%pid% 1
    else
        Run, C:\Users\vacam\Downloads\programas\nircmd-x64\nircmd.exe muteappvolume /%pid% 0
}
return