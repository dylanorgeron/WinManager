﻿; Generated by AutoGUI 1.4.7a
#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

Gui Add, Slider, x20 y43 w450 h32, 50
Gui Add, Text, x20 y13 w450 h23 +0x200, Transparency of inactive windows
Gui Show, w481 h381, Window
Return

GuiEscape:
GuiClose:
    ExitApp

; Do not edit above this line