; la ventana del latexocr (Qt692QWindowIcon) la consegui con ahk spy
#+t::  ; Ctrl+Shift+T
    ; 1. Verificar si Pix2Tex GUI está abierta
    IfWinExist, ahk_class Qt692QWindowIcon
    {
        ; ya existe, seguimos
    }
    else
    {
        ; abrir CMD y ejecutar latexocr
        ; Abrir CMD y lanzar latexocr
        Run, cmd.exe /k latexocr,, , pid  ; /k mantiene CMD abierta
        ; Esperar que la ventana GUI aparezca
        WinWait, ahk_class Qt692QWindowIcon
    }

    ; 2. Activar Pix2Tex GUI (ahora seguro que ya existe)
    WinActivate, ahk_class Qt692QWindowIcon
    WinWaitActive, ahk_class Qt692QWindowIcon

    ; 3. Enviar atajo de captura
    Send, !s
Return
