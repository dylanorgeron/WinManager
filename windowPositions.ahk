getX(position){
  RegExMatch(windowPositions, "Position" . position . "=([^,]*)", match)
  return %match1%
}
getY(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,([^,]*)", match)
  return %match1%
}
getW(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,[^,]*,([^,]*)", match)
  return %match1%
}
getH(position){
  RegExMatch(windowPositions, "Position" . position . "=[^,]*,[^,]*,[^,]*,([^,]*)", match)
  return %match1%
}

;load positions
global windowPositions =
IniRead, windowPositions, positions.ini, WindowPositions

;load hotkeys
global savedHotkeys =
IniRead, savedHotkeys, hotkeys.ini, Hotkeys