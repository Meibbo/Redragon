#Requires AutoHotkey v2.0

;--------------------------------------NAVIGATION-------------------------------|
vdDll := DllCall("LoadLibrary", "Str", "VirtualDesktopAccessor.dll", "Ptr")

MoveWindowToDesktop(direction := "right") {
    hwnd := WinGetID("A") ; Get active window
    currentDesktop := DllCall("VirtualDesktopAccessor.dll\GetCurrentDesktopNumber", "Int")
    totalDesktops := DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")
    if (direction = "left" && currentDesktop > 0) { ; Get current desktop
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
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    } ; Ensure the number is valid
    DllCall("VirtualDesktopAccessor.dll\GoToDesktopNumber", "Int", number)
}
MoveWindowToDesktopNumber(number) {
    hwnd := WinGetID("A") ; Get active window
    if (number < 0 || number >= DllCall("VirtualDesktopAccessor.dll\GetDesktopCount", "Int")) {
        return
    } ; Ensure the number is valid
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

;-------------Desktops
#1::GoToDesktopNumber(0) ; Desktop 1
#2::GoToDesktopNumber(1) ; Desktop 2
#3::GoToDesktopNumber(2) ; Desktop 3
#4::GoToDesktopNumber(3) ; Desktop 4
#!1::MoveWindowToDesktopNumber(0) ; Move window to desktop 1
#!2::MoveWindowToDesktopNumber(1) ; Move window to desktop 2
#!3::MoveWindowToDesktopNumber(2) ; Move window to desktop 3
#!4::MoveWindowToDesktopNumber(3) ; Move window to desktop 4
; AppsKey::Send("#{Tab}") ; Recent Activities

;-------------Windows
#!p::PinorUnpinWindow() ; Pin window to current desktop
#!q:: MoveWindowToDesktop("left")    ; Move window to left desktop
#!w:: MoveWindowToDesktop("right")   ; Move window to right desktop
#q::Send("!{F4}") ; Close current window

;-------------Specific applications
#HotIf WinActive("ahk_exe explorer.exe")
^q::Send("^w") ; Close current tab
^w::Send("^t") ; Open new tab
+^w::Send("+^t") ; Restore last closed tab
#HotIf WinActive("ahk_exe obsidian.exe") || WinActive("ahk_exe zen.exe")
^+D::Send("^+i") ; Developers Tools
#HotIf WinActive("ahk_exe todoist.exe") || WinActive("ahk_exe zen.exe")
F1::Send("^k") ; Open search
#HotIf


;---------------------------------APPS_FN-Keys----------------------------------|
#Esc::Send("^+#!z") ; todoist
sc120::Send("{F16}") ; kando (turn_off volume)
sc006::Send("{F13}") 
sc007::Send("{F14}")
sc008::Send("{F15}")
sc009::Send("{F16}")


;--------------------------------------KEYS-------------------------------------|
!BackSpace::Send("{Delete}") ; Delete next character
#BackSpace::Send("{Ctrl down}{Delete}{Ctrl up}") ; Delete next word
+Insert:: {  ; CapsLock
    if (GetKeyState("CapsLock", "T")) {
        SetCapsLockState("Off")
    } else {
        SetCapsLockState("On")
    }
}
^Insert::Send("{PrintScreen}")
>+Esc::Send("{F11}") 
#F::Send("{LWin}f")

;-------------Symbols
+NumpadAdd::Send("{NumpadMult}")
+sc01A::Send("``")
!NumpadAdd::Send("{NumpadMult}")
!sc00B::Send("$")
!sc035::Send("—") ; em dash
!sc01A::Send("%")
!sc028::Send("(")
!sc02B::Send("&")
+!sc028::Send(")")
*sc00C:: {  ; tecla ¿ ¡ °
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
        Send("{°}")
    else if GetKeyState("Shift", "P")
        Send("{U+00A1}") ; ¡
    else
        Send("{U+00BF}") ; ¿
}
*sc00D:: {  ; tecla ? ! |
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
        Send("{|}")
    else if GetKeyState("Shift", "P")
        Send("{!}") 
    else
        Send("{?}")
}
*sc01B:: {  ; tecla ' " #
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
        Send("{#}")
    else if GetKeyState("Shift", "P")
        Send('"')
    else
        Send("'")
}


;--------------------------------------COMPLETION------------------------------------->
::<lor::Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam euismod, nisl eget ultricies aliquam, nunc nisl ultricies nunc, quis ultricies nisl nisl eget nisl.
::<git::https://github.com/meibbo/
::<x::https://x.com/meibbos
::<twi::https://x.com/meibbos
::<tik::https://www.tiktok.com/@meibbo
::<yt::http://www.youtube.com/@meibboS
::<red::https://www.reddit.com/user/MeibboS/
::<ins::https://www.instagram.com/mophiren/
::<mail::vic_alejandronavas@outlook.com
::<amail::victorelguapito@hotmail.com
::<ti::
{
    FormatTime := Format("{:02}:{:02}", A_Hour, A_Min)
    SendText(FormatTime)
    Return
}
::<da::
{
    FormatDate := Format("{:04}-{:02}-{:02}", A_Year, A_Mon, A_DD)
    SendText(FormatDate)
    Return
}

;-------------shortcuts for specific applications
#HotIf WinActive("ahk_exe WindowsTerminal.exe")
{
    :*:zz::exit{enter}
    ;git commands
    :*:gadd::git add .{enter}
    :*:gcom::git commit -m ""{left}
    :*:gpush::git push{enter}
    :*:gpull::git pull{enter}
    :*:gstat::git status{enter}
    :*:glog::git log{enter}
    :*:gdiff::git diff{enter}
    :*:gfetch::git fetch{enter}
    :*:gclone::git clone{space}
    return
}