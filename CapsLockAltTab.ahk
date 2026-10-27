; CapsLockAltTab.ahk: Caps Lock becomes Alt+Tab, so switching windows on one
; monitor takes one key instead of two.
;
;   Tap Caps Lock             switch to the previous window (Alt+Tab)
;   Hold Caps Lock, tap Tab   keep the switcher open and step through windows
;                             (Shift+Tab steps back; arrow keys work too)
;   Release Caps Lock         go to the selected window
;   Shift+Caps Lock           turn real Caps Lock on or off
;
; While Caps Lock is held, Alt stays held, so Tab, Shift+Tab and the arrows are the
; switcher's own keys; the script doesn't need hotkeys for them.

#Requires AutoHotkey v2.0
#SingleInstance Force

SetCapsLockState "AlwaysOff"
A_IconTip := "Caps Lock = Alt+Tab (Shift+Caps Lock for capitals)"

CapsLock:: {
    Send "{Alt down}{Tab}"
    ; Key repeat while held doesn't re-fire: one thread per hotkey by default.
    KeyWait "CapsLock"
    Send "{Alt up}"
}

+CapsLock:: {
    if GetKeyState("CapsLock", "T")
        SetCapsLockState "AlwaysOff"
    else
        SetCapsLockState "AlwaysOn"
}
