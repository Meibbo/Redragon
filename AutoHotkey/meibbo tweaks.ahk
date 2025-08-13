#Requires AutoHotkey v2.0

#q::Send('^#{Left}')
#e::Send('^#{Right}')

; Load the VirtualDesktopAccessor DLL https://github.com/Ciantic/VirtualDesktopAccessor
vdDll := DllCall("LoadLibrary", "Str", "VirtualDesktopAccessor.dll", "Ptr")

; Function to move window to adjacent desktop
MoveWindowToDesktop(direction := "right") {
    hwnd := WinGetID("A") ; Get active window

    ; Get current desktop
    currentDesktop := DllCall("VirtualDesktopAccessor.dll\GetCurrentDesktopNumber", "Int")
    totalDesktops := DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")

    if (direction = "left" && currentDesktop > 0) {
        targetDesktop := currentDesktop - 1
    } else if (direction = "right" && currentDesktop < totalDesktops - 1) {
        targetDesktop := currentDesktop + 1
    } else {
        return ; Already at edge
    }

    DllCall("VirtualDesktopAccessor.dll\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", targetDesktop)
    DllCall("VirtualDesktopAccessor.dll\GoToDesktopNumber", "Int", targetDesktop)
}

GoToDesktopNumber(number) {
    ; Ensure the number is valid
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    }
    DllCall("VirtualDesktopAccessor.dll\GoToDesktopNumber", "Int", number)
}

MoveWindowToDesktopNumber(number) {
    hwnd := WinGetID("A") ; Get active window
    ; Ensure the number is valid
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    }
    DllCall("VirtualDesktopAccessor.dll\MoveWindowToDesktopNumber", "Ptr", hwnd, "Int", number)
}


PinorUnpinWindow() {
    hwnd := WinGetID("A") ; Get active window
    if (hwnd) {
        isPinned := DllCall("VirtualDesktopAccessor.dll\IsPinnedWindow", "Ptr", hwnd, "Int")
        if (isPinned) {
            DllCall("VirtualDesktopAccessor.dll\UnPinWindow", "Ptr", hwnd)
        } else {
            DllCall("VirtualDesktopAccessor.dll\PinWindow", "Ptr", hwnd)
        }
    }
}

; Hotkeys
#!q:: MoveWindowToDesktop("left")    ; Shift + Alt + Q
#!e:: MoveWindowToDesktop("right")   ; Shift + Alt + E

!1::GoToDesktopNumber(0) ; Alt + 1
!2::GoToDesktopNumber(1) ; Alt + 2
!3::GoToDesktopNumber(2) ; Alt + 3
!4::GoToDesktopNumber(3) ; Alt + 4

+!1::MoveWindowToDesktopNumber(0) ; Shift + Alt + 1
+!2::MoveWindowToDesktopNumber(1) ; Shift + Alt + 2
+!3::MoveWindowToDesktopNumber(2) ; Shift + Alt + 3
+!4::MoveWindowToDesktopNumber(3) ; Shift + Alt + 4

+!p::PinorUnpinWindow() ; Alt + P

;---------------------------------------------------KEYS------------------------------------------------>
*sc002:: {  ; tecla 1 ( ) ' 4
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc002}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send(")")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc002}{Alt up}{Ctrl up}")
    else if GetKeyState("RAlt","P")
        Send("4")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("'")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc002}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{Alt down}{sc002}{Alt up}")
    else if GetKeyState("Shift","P")
        Send("(")
    else
        Send("{sc002}")
}
*sc003::{  ; tecla 2 " [ ] 5
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc003}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("]")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc003}{Alt up}{Ctrl up}")
    else if GetKeyState("RAlt","P")
        Send("5")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("[")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc003}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{Alt down}{sc003}{Alt up}")
    else if GetKeyState("Shift","P")
        Send('"')
    else
        Send("{sc003}")
}
*sc004::{  ; tecla 3 # { } 6 
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc004}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{sc02B}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc004}{Alt up}{Ctrl up}")
    else if GetKeyState("RAlt","P")
        Send("6")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{sc028}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc004}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{Alt down}{sc004}{Alt up}")
    else if GetKeyState("Shift","P")
        Send('{#}')
    else
        Send("{sc004}")
}
*sc005::{  ; tecla F14 / < > 0
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc005}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{>}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc005}{Alt up}{Ctrl up}")
    else if GetKeyState("RAlt","P")
        Send("0")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{<}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc005}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{Alt down}{sc005}{Alt up}")
    else if GetKeyState("Shift","P")
        Send('/')
    else
        Send("{F14}")
}
*sc00C:: {  ; tecla ¿ ¡ #
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc00C}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc00C}{Alt up}{Ctrl up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{Ctrl down}{Shift down}{sc00C}{Shift up}{Ctrl up}")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{Shift down}{Alt down}{sc00C}{Alt up}{Shift up}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc00C}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{#}")
    else if GetKeyState("Shift", "P")
        Send("{U+00A1}") ; ¡
    else
        Send("{U+00BF}") ; ¿
}
*sc00D:: {  ; tecla ? ! %
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc00D}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc00D}{Alt up}{Ctrl up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{Ctrl down}{Shift down}{sc00D}{Shift up}{Ctrl up}")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{Shift down}{Alt down}{sc00D}{Alt up}{Shift up}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc00D}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("%")
    else if GetKeyState("Shift", "P")
        Send("{!}") 
    else
        Send("{?}")
}
*sc01A:: {  ; tecla ´´ `` $
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc01A}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{<}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{Ctrl down}{Shift down}{sc01A}{Shift up}{Ctrl up}")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{Shift down}{Alt down}{sc01A}{Alt up}{Shift up}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc01A}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("$")
    else if GetKeyState("Shift", "P")
        Send('``')
    else
        Send("{sc01A}") ; ´´
}
*sc01B:: {  ; tecla ' " &
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{sc01B}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{sc01B}{Alt up}{Ctrl up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{Ctrl down}{Shift down}{sc01B}{Shift up}{Ctrl up}")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{Shift down}{Alt down}{sc01B}{Alt up}{Shift up}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{sc01B}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("&")
    else if GetKeyState("Shift", "P")
        Send('"')
    else
        Send("'")
}
*NumpadDiv:: {  ; tecla Num/ ^ \
    if GetKeyState("Ctrl","P") && GetKeyState("Shift","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Shift down}{Alt down}{NumpadDiv}{Shift up}{Ctrl up}{Alt up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Alt","P")
        Send("{Ctrl down}{Alt down}{NumpadDiv}{Alt up}{Ctrl up}")
    else if GetKeyState("Ctrl","P") && GetKeyState("Shift","P")
        Send("{Ctrl down}{Shift down}{NumpadDiv}{Shift up}{Ctrl up}")
    else if GetKeyState("Alt","P") && GetKeyState("Shift","P")
        Send("{Shift down}{Alt down}{NumpadDiv}{Alt up}{Shift up}")
    else if GetKeyState("Ctrl","P")
        Send("{Ctrl down}{NumpadDiv}{Ctrl up}")
    else if GetKeyState("Alt","P")
        Send("{^}")
    else if GetKeyState("Shift","P")
        Send("{\}")
    else
        Send("{NumpadDiv}")
}
+Insert:: {  ; Shift + Fn2 + Insert -> CapsLock
    if (GetKeyState("CapsLock", "T")) {
        SetCapsLockState("Off")
    } else {
        SetCapsLockState("On")
    }
}
+!BackSpace:: {  ; Shift + Alt + Delete -> CapsLock
    if (GetKeyState("CapsLock", "T")) {
        SetCapsLockState("Off")
    } else {
        SetCapsLockState("On")
    }
}
#AppsKey::Send("{NumLock}")
NumpadEnd::Send("{Ctrl down}")
NumpadEnd up::Send("{Ctrl up}")
NumpadDown::Send("{Shift down}")
NumpadDown up::Send("{Shift up}")
NumpadPgdn::Send("{Tab}")
sc009::Send("{NumpadSub}")
sc00A::Send("{NumpadAdd}")
sc00B::Send("{NumpadMult}")
sc006::Send("{F15}")
sc007::Send("{F16}")
!sc035::Send("—")
+Esc::Send("{F11}")
!Home::Send("{sc149}")
!End::Send("{sc151}")
!NumpadHome::Send("{sc149}")
!NumpadEnd::Send("{sc151}")
!sc028::Send("|")

<^>!sc010::Send("7")
<^>!sc011::Send("8")
<^>!sc012::Send("9")
^!sc028::Send("{>}")
!BackSpace::Send("{Delete}") ; Delete previous character
#BackSpace::Send("{Ctrl down}{Delete}{Ctrl up}") ; Win + Delete → Ctrl + Backspace || Delete previous word
;+!Delete::Send("{Shift down}{Backspace}{Shift up}")

;---------------------------------------------APPS & MEDIA CONTROLS----------------------------------------->
; Volumen — Shift derecho + F8/F12
LShift & F2::Send("{Volume_Down}")
LShift & F12::Send("{Volume_Up}")
LShift & F10::Send("{Volume_Mute}")
LShift & F9::Send("{Media_Play_Pause}")
#Space::Send("{F17}") ; flow launcher
#Esc::Send("^+#!z") ; todoist
sc120::Send("{F16}") ; kando

;--------------------------------------------------NUMPAD--------------------------------------------------->
#UseHook
*NumpadClear:: {
    mods := "" ; Check which modifiers are down
    if GetKeyState("Shift", "P")
        mods .= "{Shift Down}"
    if GetKeyState("Ctrl", "P")
        mods .= "{Ctrl Down}"
    if GetKeyState("Alt", "P")
        mods .= "{Alt Down}"
    Send(mods . "{Down}") ; Release any modifiers
    if InStr(mods, "Shift")
        Send("{Shift Up}")
    if InStr(mods, "Ctrl")
        Send("{Ctrl Up}")
    if InStr(mods, "Alt")
        Send("{Alt Up}")
} ; Send Down with modifiers held
*NumpadPgUp:: {
    mods := ""
    if GetKeyState("Shift", "P")
        mods .= "{Shift Down}"
    if GetKeyState("Ctrl", "P")
        mods .= "{Ctrl Down}"
    if GetKeyState("Alt", "P")
        mods .= "{Alt Down}"
    Send(mods . "{NumpadEnd}")
    if InStr(mods, "Shift")
        Send("{Shift Up}")
    if InStr(mods, "Ctrl")
        Send("{Ctrl Up}")
    if InStr(mods, "Alt")
        Send("{Alt Up}")
} ; NumpadPgUp (9) behaves like End

;--------------------------------------------------NAVIGATION----------------------------------------------->
#HotIf WinActive("ahk_exe explorer.exe")
^q::Send("^w") ; Ctrl + Q → Ctrl + W || Close current tab
^w::Send("^t") ; Ctrl + W → Ctrl + T || Open new tab
+^w::Send("+^t") ; Shift + Ctrl + W → Shift + Ctrl + T || Restore last closed tab
#HotIf WinActive("ahk_exe obsidian.exe")
^+D::Send("^+i")
#HotIf WinActive("ahk_exe todoist.exe") || WinActive("ahk_exe zen.exe")
F1::Send("^k")
#HotIf