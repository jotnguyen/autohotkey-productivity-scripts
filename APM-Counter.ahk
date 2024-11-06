#Requires AutoHotkey v2.0
InstallKeybdHook
^!r::ExitApp  ; Ctrl+Alt+R - Exit AHK script


; ============================================
; File: APM-counter.ahk
; Description: This file contains the script for counting APM (Actions Per Minute) in a given context.
; Requires: AutoHotkey v2.0
; ============================================


; TODO: Make this script more modular and reusable
startTime := A_TickCount

MyGui := Gui()
MyGui.Add("Text", "x10 y10 w200 h30", "APM: 0")
; TODO: Make this box dynamic and scrollable
MyGui.Add("Text", "x10 y30 w200 h300", "words:")
MyGui.Show()
SetTimer(UpdateAPM, 1500)

InputHookObj := InputHook("V")
InputHookObj.KeyOpt("{All}", "-I")
InputHookObj.Start()

global previousAPM := 0

/**
 * Updates the APM (Actions Per Minute) value based on the provided actions and time.
 *
 * @param {int} actions - The number of actions performed.
 * @param {float} time - The time in minutes over which the actions were performed.
 * @return {float} - The calculated APM value.
 */
; TODO: Refactor this function to take params
UpdateAPM()
{
    global
    global actionCount := 0

    ; Start collecting input
    
    inputText := InputHookObj.Input
    ; MsgBox "Input: " inputText
    actionCount := actionCount +  StrLen(inputText)
    
    elapsedTime := (A_TickCount - startTime) / 1000
    currentAPM := Round(actionCount / elapsedTime * 60)
    
    ; average prev and cur APM
    apm := 0
    apm := (previousAPM + currentAPM) / 2
    previousAPM := currentAPM

    For Hwnd, GuiCtrlObj in MyGui
    {
        ; MsgBox "Control #" A_Index " is " GuiCtrlObj.ClassNN
        if (GuiCtrlObj.ClassNN == "Static1"){
            GuiCtrlObj.Text := "APM: " . apm
        }
        if (GuiCtrlObj.ClassNN == "Static2"){
            GuiCtrlObj.Text := "Words: " . InputHookObj.Input
        }
    }

    ; InputHookObj.Stop()
    return
}

; TODO: Include mouse clicks in APM calculation
; $*LButton::
; $*RButton::
; $*MButton::
; $*WheelUp::
; $*WheelDown::
; $*WheelLeft::
; $*WheelRight::
; {
;     actionCount++
; }

; $*::{
    
;     if (A_TimeIdleKeyboard < 1000)
;     {
;         global actionCount

;         global actionCount++
;     }
; }