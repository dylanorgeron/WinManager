#persistent

WinGet, currActiveWindow, ID, A
lastActiveWindow := currActiveWindow

SetTimer, MonitorActiveWindowChange

MonitorActiveWindowChange:
  ;get active window
  WinGet, currActiveWindow, ID, A
  ;compare to last known active window
  if (currActiveWindow != lastActiveWindow)
	{
    ;set the last known active window as this active window
    lastActiveWindow := currActiveWindow

    ;get the IDs of all windows
    WinGet, IDs, list, %title%
    ;iterate over each id
    windowIds = ""
    Loop %IDs% {
      el := IDs%A_Index%
      WinSet, Transparent, 230, % getTitleByHwnd(el)
    }
    WinSet, Transparent, OFF, A
	}
return

getTitleByHwnd(hwnd) {
  WinGetTitle, x, ahk_id %hwnd%
  return x
}
