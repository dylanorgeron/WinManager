#Include Gdip_All.ahk
#Include GDIpHelper.ahk

guidesDrawn = false

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle " ahk_id " Win)
}

#if !MouseIsOver("ahk_class ahk_class WorkerW")
Ctrl & LButton::
CoordMode, Mouse  ; Switch to screen/absolute coordinates.
MouseGetPos, EWD_MouseStartX, EWD_MouseStartY, EWD_MouseWin
WinGetPos, EWD_OriginalPosX, EWD_OriginalPosY,,, ahk_id %EWD_MouseWin%
WinGet, EWD_WinState, MinMax, ahk_id %EWD_MouseWin% 
if EWD_WinState = 0  ; Only if the window isn't maximized 
    SetTimer, EWD_WatchMouse, 10 ; Track the mouse as the user drags it.
return
#if


EWD_WatchMouse:
GetKeyState, EWD_LButtonState, LButton, P
if EWD_LButtonState = U  ; Button has been released, so drag is complete.
{
    SetTimer, EWD_WatchMouse, off
 
    StartDrawGDIP()
    ClearDrawGDIP()
    EndDrawGDIP()
    guidesDrawn = false
    CoordMode, Mouse  ; Switch to screen/absolute coordinates.
    MouseGetPos, mX, mY
    Loop, 12{
      xStart := getX(A_Index)
      xEnd := getW(A_Index) + xStart
      yStart := getY(A_Index)
      yEnd := yStart + getH(A_Index)
      if(mX >= xStart && mX <= xEnd && mY >= yStart && mY <= yEnd){
        WinMove, A,, xStart, yStart, xEnd - xStart, yEnd - yStart
        break
      }
    }
    return
}
GetKeyState, EWD_EscapeState, Escape, P
if EWD_EscapeState = D  ; Escape has been pressed, so drag is cancelled.
{
    SetTimer, EWD_WatchMouse, off
    WinMove, ahk_id %EWD_MouseWin%,, %EWD_OriginalPosX%, %EWD_OriginalPosY%
    StartDrawGDIP()
    ClearDrawGDIP()
    EndDrawGDIP()
    guidesDrawn = false
    return
}
;Draw guides if they don't exist
if (!%guidesDrawn%){
  guidesDrawn = true
  SetUpGDIP()
  StartDrawGDIP()
  ClearDrawGDIP()
  pBrush := Gdip_BrushCreateSolid(0x55ff0000)

  Loop, 12 {
    x := getX(A_Index)
    y := getY(A_Index)
    w := getW(A_Index)
    h := getH(A_Index)
    if(x != 0 || y != 0 || w != 0 || h != 0){
      Gdip_FillRectangle(G, pBrush, x, y, w, h)
      x := x + w/2 - 35
      y := y + h/2 - 35
      pos = x%x% y%y% cff990000 s72
      Gdip_TextToGraphics(G, A_Index, pos)
    }
  }
  Gdip_DeleteBrush(pBrush)
  EndDrawGDIP()
}

; Otherwise, reposition the window to match the change in mouse coordinates
; caused by the user having dragged the mouse:
CoordMode, Mouse
MouseGetPos, EWD_MouseX, EWD_MouseY
WinGetPos, EWD_WinX, EWD_WinY,,, ahk_id %EWD_MouseWin%
SetWinDelay, -1   ; Makes the below move faster/smoother.
WinMove, ahk_id %EWD_MouseWin%,, EWD_WinX + EWD_MouseX - EWD_MouseStartX, EWD_WinY + EWD_MouseY - EWD_MouseStartY
EWD_MouseStartX := EWD_MouseX  ; Update for the next timer-call to this subroutine.
EWD_MouseStartY := EWD_MouseY
return