#Requires AutoHotkey v2.0

NumpadEnd::Send("{PgUp}")     ; Numpad1 con NumLock OFF
NumpadPgUp::Send("{End}")     ; Numpad9 con NumLock OFF
NumpadClear:: {
if (GetKeyState("NumLock","T")) {
    Send("5")
} else {
    Send("{Down}")
}
}

; Volumen — Shift derecho + F1/F2/F3
LShift & F1::Send("{Volume_Down}")
LShift & F2::Send("{Volume_Up}")
LShift & F3::Send("{Volume_Mute}")

; Win + Ctrl + X → Win + Ctrl + Right
#^x::Send("{LWin down}{Ctrl down}{Right}{Ctrl up}{LWin up}")
; Win + Ctrl + Z → Win + Ctrl + Left
#^z::Send("{LWin down}{Ctrl down}{Left}{Ctrl up}{LWin up}")

; Atajos específicos por aplicación
#HotIf WinActive("ahk_exe explorer.exe") || WinActive("ahk_exe msedge.exe")
^q::Send("^w")
^w::Send("^t")
+^w::Send("+^t")
#HotIf WinActive("ahk_exe obsidian.exe")
^Tab::Send("{Backspace}")