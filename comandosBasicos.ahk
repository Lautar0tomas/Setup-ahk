#Requires AutoHotkey v2.0


;   ! → Alt
;   ^ → Ctrl
;   + → Shift
;   # → Win
                    ;ATAJOS QUE NO SON PARTE DE LOS PERSONALES(y otros que si pero menos intuitivos) PERO QUE SIRVEN DEMASIADO.
;ctrl + L -> para modificar la url del navegador 
;ctrl + / -> para la busqueda del youtube 
;ctrl + f -> para la busqueda de palabras en el navegador
;ctrl + left -> para ir para atras y ctrl + right para adelante
;en chatgpt , un atajo es escribir la barra "/" y luego lo que quieres que haga como "busca" o "piensa" etc ..  
;ctrl + shift + repag "o" avpag mueve para arriba o para abajo las ventanas del edge y en general . 
;alt + ctrl + y / n -> mueve texto arriba o abajo
;wind + e  -> abre una nueva biblioteca . 
;wind + v -> gestor de portapapeles 
;win + r -> shell:startup (capeta de inicio del usuario) 
;ctrl + wind + v -> cambiar dispositivo de salida de audio 
;alt + fin -> cambiar pestañas de ventana (con la extension de m.edge)
;ctrl + shift + t -> abre la anterior pestaña cerrada
;alt + t -> duplica la pestaña en el mismo grupo
; alt + d -> foco en visual studio 
; alt + d (navegador) -> remarcador visual de texto

; Remapea Ctrl+D a Shift+F10 solo cuando la ventana activa pertenece a msedge.exe (Edge)

; Hotkey Ctrl+D solo en Edge
#HotIf WinActive("ahk_exe msedge.exe")
     || WinActive("ahk_exe chrome.exe") 
     || WinActive("ahk_exe firefox.exe") 
     || WinActive("ahk_exe brave.exe")
     ^d::Send("+{F10}")
#HotIf



; ; Hotkey Ctrl+Alt+Y
; ^!y::
; {
    ;     title := WinGetTitle("A")                     ; título de la ventana activa
    ;     lower := StrLower(title)                      ; hacer todo minúscula para comparar
    
;     if InStr(lower, "super productivity")         ; si el título contiene "super productivity"
;     {
;         ; Secuencia para Super Productivity
;         Send("z")
;         Sleep(200)
;         Send("{Ctrl down}{Shift down}x{Shift up}{Ctrl up}")
;     }
;     else
;     {
;         ; Secuencia para cualquier otra ventana
;         Send("{Ctrl down}{Alt down}0{Alt up}{Ctrl up}")
;     }
;     return
; }


#+w::{
    Send("#{Up}")
}

#+x::{
    Send("#{Down}")
}

^!f::{
    Send("{Click}")
}

; estos atajos de teclado los tengo en powertoys 

^n::{
    Send("{Down}")
}

^y::{
    Send("{Up}")
}

^g::{
    Send("{Left}")
}

^h::{
    Send("{Right}")
}

^!g::{
    Send("^{PgUp}")
}

^!h::{
    Send("^{PgDn}")
}


!Space::{
    Send("^{Left}")
}

^Space::{
    Send("^{Right}")
}


^1::{
    Send("{PgUp}")
}

^2::{
    Send("{PgDn}")
}

!h::{
    Send("{End}")
}

!g::{
    Send("{Home}")
}

; +End::{
;     Send("{WheelDown}")
; }

; +Home::{
;     Send("{WheelUp}")
; }

!n:: {
    ; acción 1
    Send "{U+00F1}"
}


CapsLock::{
    return
}

^Left::{
    Send("{XButton1}")
}

^Right::{
    Send("{XButton2}")
}

+!h::{
    Send("+{Right}")    
}

+!g::{
    Send("+{Left}")
}


+!y::{
    Send("+{Up}")
}

+!n::{
    Send("+{Down}")
}





#SingleInstance Force
SendMode "Input"

; Configuración ajustable
scrollAmount := 1         ; Cantidad de líneas a desplazar con teclado
wheelDebounceTime := 100    ; Tiempo mínimo entre clicks de rueda (ms)

; Variables para control de la rueda
lastMButtonTime := 0
mButtonBlocked := false

; Filtro para el botón central del ratón (rueda)
~MButton:: {
    global lastMButtonTime, mButtonBlocked, wheelDebounceTime
    
    if (mButtonBlocked) {
        return  ; Ignorar clicks bloqueados
    }
    
    currentTime := A_TickCount
    timeSinceLast := currentTime - lastMButtonTime
    
    if (timeSinceLast < wheelDebounceTime) {
        mButtonBlocked := true
        SetTimer ResetMButtonBlock, -wheelDebounceTime
        return
    }
    
    lastMButtonTime := currentTime
    ; El ~ permite que el click normal se procese
}

ResetMButtonBlock() {
    global mButtonBlocked := false
}

; Desplazamiento con teclado - NO AFECTADO POR EL FILTRO
+Home:: {
    global scrollAmount
    Send "{WheelUp " scrollAmount "}"  ; Envía múltiples eventos a la vez
}

+End:: {
    global scrollAmount
    Send "{WheelDown " scrollAmount "}"  ; Envía múltiples eventos a la vez
}


; #SingleInstance Force
; SendMode "Input"

; ; Configuración ajustable
; scrollAmount := 1 ; Cantidad de líneas a desplazar (ajusta según necesidad)

; ; Desplazamiento hacia arriba (Shift+Home)
; +Home:: {
;     global scrollAmount
;     Loop scrollAmount {
;         Send "{WheelUp}"
;         Sleep 5  ; Pequeña pausa para mejor compatibilidad , Reduce para más velocidad o aumenta para más suavidad
;     }
; }

; ; Desplazamiento hacia abajo (Shift+End)
; +End:: {
;     global scrollAmount
;     Loop scrollAmount {
;         Send "{WheelDown}"
;         Sleep 5  ; Pequeña pausa para mejor compatibilidad , Reduce para más velocidad o aumenta para más suavidad
;     }
; }