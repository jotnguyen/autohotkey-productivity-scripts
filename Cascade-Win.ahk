#Requires AutoHotkey v2.0
#SingleInstance force		; Cannot have multiple instances of program

^!r::Reload  ; Ctrl+Alt+R - Reload the AHK script

; ============================================
; File: Cascade-Win.ahk
; Description: This file contains the Monitor class for managing monitors and an example usage to cascade windows across multiple monitors.
; Requires: AutoHotkey v2.0
; ============================================

; ============================================
; AHKv2 Window management
; ============================================
^j::WinMinimize "A"  ; Ctrl+J - Minimize active window

class Monitor {
    static GetInfo(hMonitor) {
        if !hMonitor {
            MsgBox "Invalid monitor handle"
            return false
        }
        
        info := Buffer(40, 0)  ; MONITORINFO structure
        NumPut("UInt", 40, info, 0)  ; Set cbSize
        
        result := DllCall("GetMonitorInfoW", 
            "Ptr", hMonitor,
            "Ptr", info,
            "Int")
            
        if !result {
            error := A_LastError
            MsgBox "GetMonitorInfoW failed. Error: " error
            return false
        }
        
        return {
            left:      NumGet(info,  4, "Int"),
            top:       NumGet(info,  8, "Int"),
            right:     NumGet(info, 12, "Int"),
            bottom:    NumGet(info, 16, "Int"),
            workLeft:  NumGet(info, 20, "Int"),
            workTop:   NumGet(info, 24, "Int"),
            workRight: NumGet(info, 28, "Int"),
            workBottom:NumGet(info, 32, "Int"),
            primary:   NumGet(info, 36, "UInt")
        }
    }

    static monitorList := []

    static EnumProc(hMonitor, hdc, lpRect, lParam) {
        ; MsgBox "EnumProc called with monitor handle: " hMonitor
        
        monInfo := Monitor.GetInfo(hMonitor)
        if monInfo {
            Monitor.monitorList.Push(monInfo)
        }
        return true
    }

    static GetMonitors() {
        Monitor.monitorList := []
        
        ; Create a bound function for the callback
        boundFunc := Monitor.EnumProc.Bind(Monitor)
        
        ; Create the callback with the bound function
        callback := CallbackCreate(boundFunc, "Fast", 4)
        
        result := DllCall("EnumDisplayMonitors",
            "Ptr", 0,       ; HDC
            "Ptr", 0,       ; LPRECT
            "Ptr", callback, ; MONITORENUMPROC
            "Ptr", 0,       ; LPARAM
            "Int")
            
        if !result {
            error := A_LastError
            MsgBox "EnumDisplayMonitors failed. Error: " error
            CallbackFree(callback)
            return []
        }
        
        CallbackFree(callback)
        return Monitor.monitorList.Clone()
    }

    static FromWindow(hwnd) {
        if !hwnd := WinExist(hwnd)
            return false
            
        hMon := DllCall("MonitorFromWindow", 
            "Ptr", hwnd,
            "UInt", 2,  ; MONITOR_DEFAULTTONEAREST
            "Ptr")
            
        if !hMon
            return false
            
        return Monitor.GetInfo(hMon)
    }
}

; ============================================
; Example Usage
; ============================================

; Win+F - Cascade windows across monitors
#F:: {
    try {
        monitors := Monitor.GetMonitors()
        if !monitors.Length {
            MsgBox "No monitors found!"
            return
        }

        ; Get list of windows we want to cascade
        windows := []
        for hwnd in WinGetList() {
            ; Skip if window isn't valid
            if !WinExist("ahk_id " hwnd)
                continue
                
            ; Add to our list
            windows.Push(hwnd)
        }
        
        if !windows.Length {
            MsgBox "No suitable windows found!"
            return
        }
        
        ; Initialize position trackers for each monitor
        posTrackers := Map()
        for i, mon in monitors {
            posTrackers[i] := {
                x: mon.workLeft,
                y: mon.workTop
            }
        }
        
        ; Process each window in reverse order using negative indices
        loop windows.Length {
            ; Get window using negative index (starts from last window)
            hwnd := windows[-A_Index]
            
            ; Get the monitor this window is on
            monInfo := Monitor.FromWindow("ahk_id " hwnd)
            if !monInfo
                continue
                
            ; Find which monitor index this is
            monIndex := 1
            found := false
            for i, mon in monitors {
                if (mon.left = monInfo.left && mon.top = monInfo.top) {
                    monIndex := i
                    found := true
                    break
                }
            }
            
            if !found
                continue
                
            ; Calculate window size
            width := Round((monInfo.workRight - monInfo.workLeft) * 0.55)
            height := Round((monInfo.workBottom - monInfo.workTop) * 0.70)
            
            ; Get current position for this monitor
            if !posTrackers.Has(monIndex)
                continue
                
            pos := posTrackers[monIndex]
            
            ; Bring window to top before moving it
            WinActivate "ahk_id " hwnd
            
            ; Move and resize the window
            try {
                WinMove pos.x, pos.y, width, height, "ahk_id " hwnd
            } catch as err {
                continue
            }
            
            ; Update position for next window
            pos.x += 30
            pos.y += 30
            
            ; TODO: Fix sometimes windows go off screen
            ; Reset position if going off screen
            if (pos.x + width > monInfo.workRight) || (pos.y + height > monInfo.workBottom) {
                pos.x := monInfo.workLeft
                pos.y := monInfo.workTop
            }
        }
        
    } catch as e {
        MsgBox "Error: " e.Message "`nLine: " e.Line "`nWhat: " e.What
    }
}