#Requires AutoHotkey v2.0
#SingleInstance force		; Cannot have multiple instances of program
A_MaxHotkeysPerInterval := 200	; Won't crash if button held down
; DetectHiddenWindows True

SetCapsLockState "AlwaysOff"

; Caplocks to clear and click
CapsLock::ClearAndClick

xhairArray := []

; Clear and click
ClearAndClick(*){
    ; Clean up GUI
    for (xhair in xhairArray)
    {
        xhair.Delete()
    }
    Click
}

; Vimlike bindings
; CapsLock & h:: Left
; CapsLock & j:: Down
; CapsLock & k:: Up
; CapsLock & l:: Right

^!r::Reload

Hotkey "^;", InitKeynav ; Ctrl + alt + ;
; global x0, y0, x, y, w, h, box, hori, verti, active, dragging
class KNav {
    ;; Experimental
    Coord := Object()

    __new(Coord) {
        this.Coord := Coord
    }
    
    getCoord() {
        return this.Coord
    }
    
}

; 
; CrossHair class
; This class is responsible for creating and managing a crosshair overlay on the screen.
; It initializes three GUI elements: box, hori, and verti.
; 
; Properties:
; - box: A GUI element representing the box part of the crosshair.
; - hori: A GUI element representing the horizontal line of the crosshair.
; - verti: A GUI element representing the vertical line of the crosshair.
; 
; Methods:
; - __new(): Constructor method for initializing the CrossHair class.
; 
class CrossHair {
    ; TODO: Refactor into Crosshair class
    box := Gui()
    hori := Gui()
    verti := Gui()

    __new()
    {

    }

}

/*
Initializes the key navigation system by setting up the navigation coordinates, 
creating GUI elements for the crosshair, and configuring their properties.

Parameters:
* - No parameters are used in this function.

Globals:
nav - An instance of KNav with screen dimensions.
box - A GUI element representing the box with a red background.
hori - A GUI element representing the horizontal crosshair with a blue background.
verti - A GUI element representing the vertical crosshair with a blue background.
active - A boolean indicating if the navigation is active.
dragging - A boolean indicating if dragging is enabled.

Returns:
None
*/
InitKeynav(*)
{
    global nav
    nav := KNav({x0: 0, y0: 0, x1: A_screenWidth, y1: A_screenHeight})
    nav.Coord := {x0: 0, y0: 0, x1: A_screenWidth, y1: A_screenHeight}


    ; global w 
    nav.Coord.w := (nav.Coord.x1 - nav.Coord.x0) / 2 ; width of crosshair
    ; global h 
    nav.Coord.h := (nav.Coord.y1 - nav.Coord.y0) / 2 ; height of crosshair
    
    global box 
    box := Gui()
    box.BackColor := "Red"

    ; TODO: Refactor into crosshair object
    global hori 
    hori := Gui()
    hori.Title := "Horizontal Cross"
    hori.Opt("+E0x00000020L -Caption +ToolWindow +AlwaysOnTop +LastFound")
    hori.BackColor := "Blue"
    xhairArray.Push hori
    
    global verti 
    verti := Gui()
    verti.Title := "Vertical Cross"
    verti.Opt("+E0x00000020L -Caption +ToolWindow +AlwaysOnTop +LastFound")
    verti.BackColor := "Blue"
    xhairArray.Push verti
    ; WinSetTransColor "Blue", "Horizontal"
    ; WinSetTransColor "Blue", "Vertical"
    global active
    active := false

    ;; Still not sure what dragging is used for
    global dragging
    dragging := true
    Redraw(nav)
    return
}

/*
Redraws the crosshair GUI elements based on the current navigation coordinates.

Parameters:
nav - An instance of KNav containing the current navigation coordinates.

Returns:
None
*/
Redraw(nav)
{
    ;; Instantiate new nav and add it to array
    newNav := nav.Clone()

    ; TODO: Move Hori and Verti into Crosshair Class?
    newHori := Gui()
    newHori.Title := "Horizontal Cross"
    newHori.Opt("+E0x00000020L -Caption +ToolWindow +AlwaysOnTop +LastFound")
    newHori.BackColor := "Blue"
    

    newVerti := Gui()
    newVerti.Title := "Vertical Cross"
    newVerti.Opt("+E0x00000020L -Caption +ToolWindow +AlwaysOnTop +LastFound")
    newVerti.BackColor := "Blue"

    ; (0,0) Topleft of monitor
    ;; This x and y definition makes Redraw Half it already?
    newNav.coord.x := (nav.getCoord().x0 + nav.getCoord().x1) / 2 ; x-midmight
    newNav.coord.y := (nav.getCoord().y0 + nav.getCoord().y1) / 2 ; y-midpoint


    ;; These might be able to be compute properties
    ; These are halfed every time
    w := (nav.getCoord().x1 - nav.getCoord().x0) ; width of crosshair
    h := (nav.getCoord().y1 - nav.getCoord().y0) ; height of crosshair
    
    newHori.Show("x" newNav.getCoord().x0 " y" newNav.getCoord().y " h" 4 " w" w) ; top right rn

    newVerti.Show("x" newNav.getCoord().x " y" newNav.getCoord().y0 " h" h " w" 4) ; bot right rn
    xhairArray.Push newHori
    xhairArray.Push newVerti

    WinSetTransparent 50, "Horizontal"
    WinSetTransparent 24, "Vertical"

    WinSetTransColor "Blue", "Horizontal Cross"
    WinSetTransColor "Blue", "Vertical Cross"

    if dragging {
        MouseMove nav.Coord.x, nav.Coord.y
    }
    return
}


HotIfWinExist("Vertical")
Numpad1:: ; left click
{
    Click
}

; Keybindings as hotstrings
#HotIf WinActive("Vertical")
    CoordMode "Mouse", "Screen"

    ^;:: 
    {
        x0 := 0
        x1 := A_screenWidth
        y0 := 0
        y1 := A_screenHeight
        active := true
        Redraw(nav)
        return
    }
     
    `;:: ; close and release?
    {
        active := false
        if dragging {
            Send "{Click, Up}"
        }
        dragging := false
        hori.Hide()
        verti.Hide()
        return
    }

    h:: ; left
    {
        nav.Coord.x1 := (nav.getCoord().x0 + nav.getCoord().x1) / 2
        Redraw(nav)
        return
    }
    j:: ; down
    {
        
        nav.Coord.y0 := (nav.getCoord().y0 + nav.getCoord().y1) / 2
        Redraw(nav)
        return
    }

    k:: ; up
    {
        nav.Coord.y1 := (nav.getCoord().y0 + nav.getCoord().y1) / 2
        Redraw(nav)
        return
    }

    l:: ; right
    {
        nav.Coord.x0 := (nav.getCoord().x0 + nav.getCoord().x1) / 2
        Redraw(nav)
        return
    }

    w:: ; center
    {
        xi := Floor(nav.getCoord().x)
        yi := Floor(nav.getCoord().y)
        DllCall("SetCursorPos", "int", xi, "int", yi)

        ;; TODO: Maybe clear and reset here??
        return
    }

    1:: ; left click
    {
        MouseClick
        return
    }

    3:: ; right click
    {
        Send "{Click Right}"
        return
    }

    4::
    {
        Send "{Click WheelUp}"
        return
    }

    5::
    {
        Send "{Click WheelUp}"
        return
    }

    <+k:: ; up
    {
        increment := (nav.getCoord().y1 - nav.getCoord().y0)
        nav.Coord.y0 := nav.getCoord().y0 - increment
        nav.Coord.y1 := nav.getCoord().y1 - increment
        Redraw(nav)
        return
    }

    <+j:: ; down 1
    {
        increment := (nav.getCoord().y1 - nav.getCoord().y0)
        nav.Coord.y0 := nav.getCoord().y0 + increment
        nav.Coord.y1 := nav.getCoord().y1 + increment
        Redraw(nav)
        return
    }

    <+h:: ; left
    {
        increment := (nav.getCoord().x1 - nav.getCoord().x0)
        nav.Coord.x0 := nav.getCoord().x0 - increment
        nav.Coord.x1 := nav.getCoord().x1 - increment
        Redraw(nav)
        return
    }

    <+l:: ; shift + l: right
    {
        increment := (nav.getCoord().x1 - nav.getCoord().x0)
        nav.Coord.x0 := nav.getCoord().x0 + increment
        nav.Coord.x1 := nav.getCoord().x1 + increment
        Redraw(nav)
        return
    }
    
    c::
    {
        MouseGetPos &xpos, &ypos
        nav.getCoord().x0 := xpos - 100
        nav.getCoord().x1 := xpos + 100
        nav.getCoord().y0 := ypos - 100
        nav.getCoord().y1 := ypos + 100
        Redraw(nav)
        return
    }

    x::
    {
        midx := (nav.getCoord().x0 + nav.getCoord().x1) / 2
        nav.getCoord().x0 := midx - 100
        nav.getCoord().x1 := midx + 100
        ypos := (nav.getCoord().y0 + nav.getCoord().y1) / 2
        nav.Coord.y0 := ypos - 100
        nav.Coord.y1 := ypos + 100
        Redraw(nav)
        return
    }

    d::
    {
        Send "Click Down"
        nav.dragging := true
        return
    }



    o:: ;; Switch monitors
    {
        static monitorCount := 0
        static currentMonitor := MonitorGetPrimary()
        MonitorPrimary := MonitorGetPrimary()
        monitorCount := SysGet(80)

        ; Cycle monitors
        currentMonitor := Mod(currentMonitor, monitorCount) + 1 

        MonitorGet currentMonitor, &Left, &Top, &Right, &Bottom

        ; TODO: clear primary monitor

        ; SysGet Mon, Monitor, 1
        nav.getCoord().x0 := Left
        nav.getCoord().x1 := Right
        nav.getCoord().y0 := Top
        nav.getCoord().y1 := Bottom
        Redraw(nav)
        return
    }


    ; TODO; Clear all the GUIs drawn without reloading
    ; Flash?
#HotIf