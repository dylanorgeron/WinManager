#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

#Include windowTileSettings.ahk

Gui MainGui:+AlwaysOnTop
Gui MainGui:+Resize

Gui MainGui:Add, Tab3,, Positons|Shortcuts|Settings 

xPadding = 20
sectionHeight = 60

;Add controls
Loop, 12 {
  ;Fetch vars
  yOffset := (A_Index - 1) * 60 ;final number is height of section. yOffset is used to position the next section below the previous section
  yPosLabelOffset := yOffset + 40
  yCoordsOffset := yOffset + 60
  yButtonOffset := yOffset + 60
  yDivOffset := yOffset + 90
  positionCoordsText := "X: " getX(A_Index) ", Y: " getY(A_Index) ", W: " getW(A_Index) ", H: " getH(A_Index) ;get coords string
  
  ;Build gui
  Gui MainGui:Add, Text, x%xPadding% y%yPosLabelOffset% w100 h23 +0x200, Position %A_Index% ; position label
  Gui MainGui:Add, Text, vP%A_Index%Position x%xPadding% y%yCoordsOffset% w700 h23 +0x200, %positionCoordsText% ;coords
  Gui MainGui:Add, Button, x373 y%yButtonOffset% w100 h25 gSetPosition%A_Index%, Change Location ;location button
  Gui MainGui:Add, Text, x%xPadding% y%yDivOffset% w460 0x10 ;divider
}

Gui MainGui:Show, w500 h775, Win Manager
Return

;Labels for setting position
SetPosition1:
  launchSetPositionWindow(1)
  return  
SetPosition2:
  launchSetPositionWindow(2)
  return
SetPosition3:
  launchSetPositionWindow(3)
  return
SetPosition4:
  launchSetPositionWindow(4)
  return
SetPosition5:
  launchSetPositionWindow(5)
  return
SetPosition6:
  launchSetPositionWindow(6)
  return
SetPosition7:
  launchSetPositionWindow(7)
  return
SetPosition8:
  launchSetPositionWindow(8)
  return
SetPosition9:
  launchSetPositionWindow(9)
  return
SetPosition10:
  launchSetPositionWindow(10)
  return
SetPosition11:
  launchSetPositionWindow(11)
  return
SetPosition12:
  launchSetPositionWindow(12)
  return

;Saving position after tiling window to desired location
SavePositionSettings:
  WinGetPos, X, Y, Width, Height, A
  WinGetTitle, positionAsTitle, A
  StringRight, position, positionAsTitle, 1
  writePositionCoords(position, X, Y, Width, Height)
  GuiControl, MainGui:, P%position%Position, X: %X%`, Y: %Y%`, W: %Width%`, H: %Height%`,
  Gui SetPositionGui:Submit
  Gui MainGui:+AlwaysOnTop
  return

;Create window for seting position
launchSetPositionWindow(positionToSet){
  Gui MainGui:-AlwaysOnTop
  Gui SetPositionGui:+AlwaysOnTop
  Gui SetPositionGui:+Resize
  Gui SetPositionGui:Add, Text, x15 y10 w340 h23 +0x200, Drag this window into the desired position for position %positionToSet%.
  Gui SetPositionGui:Add, Button, x15 y40 w200 h23 gSavePositionSettings, Save Window Position
  Gui SetPositionGui:Show, w490 h100, Set Position %positionToSet%
  return
}

;Close
MainGuiGuiEscape:
MainGuiGuiClose:
  ExitApp

