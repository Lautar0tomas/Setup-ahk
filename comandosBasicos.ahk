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
;wind + e  -> abre una nueva biblioteca . 


#SingleInstance Force

; Atajo condicional para Edge
#HotIf WinActive("ahk_exe msedge.exe") ; funciona unicamente si se habre el "edge" 
!t:: {  ; Alt+T solo en Edge
    Send "^+k"  ; imita a  "Ctrl+Shift+K"
    return
}
#HotIf  ; Restablece el contexto para otros hotkeys


#+w::{
    Send("#{Up}")
}

#+x::{
    Send("#{Down}")
}

^!f::{
    Send("{Click}")
}

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

!Space::{
    Send("^{Left}")
}

^Space::{
    Send("^{Right}")
}

^!g::{
    Send("^{PgUp}")
}

^!h::{
    Send("^{PgDn}")
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

!n::{
    Send("ñ")
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
scrollAmount := 2           ; Cantidad de líneas a desplazar con teclado
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