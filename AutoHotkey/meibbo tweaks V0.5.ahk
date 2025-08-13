#Requires AutoHotkey v2.0

; ↔ Intercambio F10 ↔ F11
F11::F10
F10::F11

; Volumen — Shift derecho + F1/F2/F3
RShift & F1::Send("{Volume_Down}")
RShift & F2::Send("{Volume_Up}")
RShift & F3::Send("{Volume_Mute}")

; Alt izquierdo + Z → envía "<"
RAlt & z::Send(GetKeyState("Shift") ? ">" : "<")

; Ctrl izquierdo + Alt derecho + { → envía "}"
RAlt & {:: {
    if GetKeyState("RControl") && GetKeyState("Shift")
        Send "{text}``"
    else if GetKeyState("Shift")
        Send "]"
    else
        Send "{raw}}"
}

; Win + Ctrl + X → Win + Ctrl + Right
#^x::Send("{LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}")

; Win + Ctrl + Z → Win + Ctrl + Left
#^z::Send("{LWin down}{Ctrl down}{Left}{Ctrl up}{LWin up}")

; Atajos específicos por aplicación
#HotIf WinActive("ahk_exe explorer.exe") || WinActive("ahk_exe msedge.exe")
^q::Send("^w")
^w::Send("^t")
; Fin del contexto específico