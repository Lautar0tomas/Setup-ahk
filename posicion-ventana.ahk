#Requires AutoHotkey v2.0

#+s:: {
    ; Ejecutar el atajo nativo para mover entre monitores
    Send "#+{Left}"
    
    ; Pequeña pausa para permitir la transición
    Sleep 0
    
    ; Verificar estado actual de la ventana después de mover
    estadoActual := WinGetMinMax("A")
    
    ; Centrar solo si la ventana está en estado normal (no maximizada/minimizada)
    if (estadoActual == 0) {
        ; Obtener posición actual de la ventana
        WinGetPos &X, &Y, &Ancho, &Alto, "A"
        
        ; Determinar monitor actual basado en la nueva posición
        numMonitor := MonitorDesdePunto(X, Y)
        
        ; Obtener área de trabajo del monitor
        MonitorGetWorkArea numMonitor, &Izq, &Arr, &Der, &Abj
        
        ; Calcular posición centrada
        nuevaX := Izq + ((Der - Izq - Ancho) // 2)
        nuevaY := Arr + ((Abj - Arr - Alto) // 2)
        
        ; Mover ventana al centro conservando su tamaño
        WinMove nuevaX, nuevaY,,, "A"
    }
}

MonitorDesdePunto(X, Y) {
    Loop MonitorGetCount() {
        MonitorGet A_Index, &MIzq, &MArr, &MDer, &MAbj
        if (X >= MIzq && X < MDer && Y >= MArr && Y < MAbj)
            return A_Index
    }
    return 1
}


; Mapa de títulos de ventana → coordenadas de cliente (x, y)
windowTargets := Map(
    "oveja MEEEE vaca MUUUU",  {x: 952, y: 935},
    "vaca MUUUU oveja MEEEE",  {x: 952, y: 935}
)

^!j:: {
    activeTitle := WinGetTitle("A")
    coords := windowTargets.Get(activeTitle, "")
    if !coords
        return

    ; Guardar posición actual del cursor (coordenadas de pantalla)
    CoordMode("Mouse", "Screen")
    MouseGetPos(&origX, &origY)

    ; Mover y hacer clic en las coordenadas de cliente de la ventana activa
    CoordMode("Mouse", "Client")
    MouseMove(coords.x, coords.y, 0)
    Click()

    ; Restaurar la posición original del cursor
    CoordMode("Mouse", "Screen")
    MouseMove(origX, origY, 0)
}

