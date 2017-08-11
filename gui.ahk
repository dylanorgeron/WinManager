#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

#Include windowTileSettings.ahk

Gui MainGui:+AlwaysOnTop
Gui MainGui:Add, Text, x15 y10 w120 h23 +0x200, Window Positions ;window header

Gui MainGui:Add, Text, x15 y40 w50 h23 +0x200, Position 1 ; Position 1
position1CoordsText := "X: " getX(1) ", Y: " getY(1) ", W: " getW(1) ", H: " getH(1) ;get coords string
Gui MainGui:Add, Text, x15 y40 w50 h23 +0x200, Position 1 ;location label
Gui MainGui:Add, Text, vP1Position x15 y60 w700 h23 +0x200, %position1CoordsText% ;coords
Gui MainGui:Add, Button, x373 y60 w100 h25 gSetPosition1, Change Location ;location button
Gui MainGui:Add, Text, x15 y90 w460 0x10 ;divider

Gui MainGui:Add, Text, x15 y100 w50 h23 +0x200, Position 2 ; Position 2
position2CoordsText := "X: " getX(2) ", Y: " getY(2) ", W: " getW(2) ", H: " getH(2) ;get coords string
Gui MainGui:Add, Text, x15 y100 w50 h23 +0x200, Position 2 ;location label
Gui MainGui:Add, Text, vP2Position x15 y120 w700 h23 +0x200, %position2CoordsText% ;coords
Gui MainGui:Add, Button, x373 y120 w100 h25 gSetPosition2, Change Location ;location button

Gui MainGui:Show, w490 h381, Win Manager
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

