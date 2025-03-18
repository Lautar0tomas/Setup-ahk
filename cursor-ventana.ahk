; Establecer el modo de coordenadas en pantalla para evitar discrepancias
CoordMode, Mouse, Screen
CoordMode, ToolTip, Screen

#Persistent
SetTimer, CheckActiveWindow, 50  ; Verifica cada 100 milisegundos
return

; el modificador (~) permite que el atajo no se bloquee y pueda tener su uso predeterminado.
~LButton:: SetTimer, CheckActiveWindow, Off 
~RButton:: SetTimer, CheckActiveWindow, Off
~!Tab:: SetTimer, CheckActiveWindow, On
~LWin:: SetTimer, CheckActiveWindow, On
~!F4:: SetTimer, CheckActiveWindow, On
~MButton:: SetTimer, CheckActiveWindow, Off

CheckActiveWindow:
    ; Obtener el identificador de la ventana activa
    WinGet, current_id, ID, A
    if (current_id != last_id)
    {
        last_id := current_id
        ; Pequeño retardo para asegurar que la ventana se haya posicionado correctamente
        Sleep, 50
        
        ; Verificar que la ventana no esté minimizada (MinMax: -1 minimizada, 1 maximizada, 0 normal)
        WinGet, MinMax, MinMax, ahk_id %current_id%
        if (MinMax = -1)
            return
        
        ; Obtener la posición (X, Y) y el tamaño (Width, Height) de la ventana activa
        WinGetPos, X, Y, Width, Height, ahk_id %current_id%
        
        ; Solo proceder si se obtuvieron dimensiones válidas
        if (Width > 0 && Height > 0)
        {
            ; Calcular el centro de la ventana
            centerX := X + (Width / 2)
            centerY := Y + (Height / 2)
            ; Mover el cursor al centro instantáneamente
            MouseMove, %centerX%, %centerY%, 0
        }
    }
return



