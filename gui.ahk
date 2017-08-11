﻿#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

#Include windowTileSettings.ahk

Gui MainGui:+AlwaysOnTop
Gui MainGui:Add, Tab3, x10 y10 w480, Positons|Shortcuts|Settings 

numSections = 12
xPadding = 20
sectionHeight = 60

;Position controls
Loop,% numSections {
  ;Fetch vars
  yOffset := (A_Index - 1) * 40 ;final number is height of section. yOffset is used to position the next section below the previous section
  yCoordsOffset := yOffset + 40
  yButtonOffset := yOffset + 40
  yDivOffset := yOffset + 70
  positionCoordsText := "Position " A_Index ": " getX(A_Index) ", " getY(A_Index) ", " getW(A_Index) ", " getH(A_Index) ;get coords string
  
  ;Build gui
  Gui MainGui:Add, Text, vP%A_Index%Position x%xPadding% y%yCoordsOffset% w700 h23 +0x200, %positionCoordsText% ;coords
  Gui MainGui:Add, Button, x373 y%yButtonOffset% w100 h25 gSetPosition%A_Index%, Change Position %A_Index% ;location button
  Gui MainGui:Add, Text, x%xPadding% y%yDivOffset% w460 0x10 ;divider
}

;Hotkey controls
#Include hotkeyControls.ahk

Gui MainGui:Show, w500 h530, Win Manager
Return

;Saving position after tiling window to desired location
SavePositionSettings:
  WinGetPos, X, Y, Width, Height, A
  WinGetTitle, positionAsTitle, A
  StringRight, position, positionAsTitle, 1
  writePositionCoords(position, X, Y, Width, Height)
  GuiControl, MainGui:, P%position%Position, Position %position%: %X%`, %Y%`, %Width%`, %Height%`,
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

;Repeated Labels
#Include labels.ahk


;Close
MainGuiGuiEscape:
MainGuiGuiClose:
  ExitApp

